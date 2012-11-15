<?php
  require_once "libs/Download.php";
  require_once "libs/GvStrings.php";
  require_once "libs/GvHtmlSrv.php";
  require_once "libs/utf2win.php";
  require_once "booker_xml.php";
  
class betcity_booker extends booker_xml {
  
  private $header;
  private $event_date;
  
  function __construct() { 
    $this->booker = 'betcity'; 
    $this->host = 'http://betcityru.com';
    parent::__construct();
  }
  
  private function extract_league(&$tournirs_node, $html) {
    $html = copy_be($html, '<table ', '</table>', 'class="bt"');
    $tournirs = extract_all_tags($html, '<tr>', '</tr>', 'line_id[]');
    foreach($tournirs as $tournir) {
      $tournir = kill_space($tournir);
      $tournir_name = copy_be($tournir, '<a', '</a>');
      $tournir_name = copy_between($tournir_name, '>', '</');
      $tournir_node = $tournirs_node->addChild('Tournir');
      $tournir_id = copy_be($html, '<input', '>');
      $league = copy_between($tournir, 'value="', '"');
      $tournir_node->addAttribute('Id', $league);
      $tournir_node->addAttribute('Region', 'World');
      $tournir_node->addAttribute('Title',  $tournir_name);
    }
  }

  public function getTournirs($sport_id) {
    // Зачитываем настройку конторы
    $xml = parent::getTournirs($sport_id);
    $tournirs_node = $xml->addChild('Tournirs');
    
    // получаем перечень турниров
    $file_name = $this->league_path."league";
    $url = $this->host.$this->sport_node['Url'];
    $html = download_or_load($this->debug, $file_name.".html", $url, "GET");
    $this->extract_league($tournirs_node, win1251_to_utf8($html));
    if ($this->debug) file_put_contents($file_name.".xml", $xml->asXML());
    return $xml;
  }

  private function decode_date($str) {
    if (preg_match('/(\d{1,2})\.(\d{1,2})\.(\d{4})/i', $str, $matches)) { //MMM DD, YYYY
      $day_no = $matches[1];
      $month_no = $matches[2];
      $year_no = $matches[3];
    }
    return array($day_no, $month_no, $year_no);
  }

  private function decode_time($str) {
    preg_match('/(\d{1,2}):(\d\d) (PM|AM)/i', $str, $matches);
    $hour = $matches[1];
    $minute = $matches[2];
    $pmam = $matches[3];
    if (($pmap == 'AM') and ($hour == 12)) {
      $hour = 0;
    } elseif (($pmam == 'PM') and ($hour < 12)) {
      $hour = $hour + 12;
    }
    return array($hour, $minute);
  }

  private function event_find(&$tournir_node, $event_id) {
     foreach($tournir_node as $event_node) {
       if ((string)$event_node['Id'] == $event_id)
         return $event_node;
     }
     return false;
  }

  private function extract_label_koef($html) {
    $label = delete_all(copy_be($html, '<li', '<b>'), '<', '>');
    $koef = delete_all(copy_be($html, '<b', '</li>'), '<', '>');
    return array($label, $koef);
  }

  private function event_create(&$tournir_node, $event_id, $datetime, $gamer1_name, $gamer2_name) {
     $event_node = $tournir_node->addChild('Event');
     $event_node->addAttribute('Id', $event_id);
     $event_node->addAttribute('DateTime', date('Y-m-d\TH:i:s', $datetime));
     $event_node->addAttribute('Gamer1_Name', $gamer1_name);
     $event_node->addAttribute('Gamer2_Name', $gamer2_name);
     return $event_node;
  }

  private function extract_header($sport_sign, $thead) {
    $thead = str_ireplace('фора', 'фора1', $thead, 1);
    $thead = str_ireplace('фора', 'фора2', $thead, 1);
    $thead = str_ireplace('кф', 'кф1', $thead, 1);
    $thead = str_ireplace('кф', 'кф2', $thead, 1);
    $cols = extract_all_tags($thead, '<td', '</td>');
    foreach ($cols as $col) {
      $col = delete_all($col, '<', '>');
      $phrase_node = $this->findPhrase($sport_sign, 'Header', $col);
      $this->header[] = (string) $phrase_node['BetKind'];
    }
  }
  
  
  private function extract_main_bets_tennis(&$tournir_node, $html, $sport_sign, $tournir_id) {
    $html = copy_be($html, '<tr class="tc', '</tr>');
    $event_id = copy_between($html, 'shdop(\'', '\'');
    $html = kill_tag_bound($html, 'b|a');
    $cells = extract_all_tags($html, '<td>', '</td>');
    list($hour, $minute) = $this->decode_time($cells[0]);
    $gamer1_name = $cells[1];
    $gamer2_name = $cells[4];
    $event_node = $this->event_create($tournir_node, $event_id, mktime(a$hour, $minute, 0, $month_no, $day_no, $year_no), $gamer1_name, $gamer2_name);
    if ($cells[3] <> '') $this->addBet($event_node, $this->header[3].';Koef='.$cells[3]);
    if ($cells[4] <> '') $this->addBet($event_node, $this->header[4].';Koef='.$cells[4]);
    if ($cells[5] <> '') $this->addBet($event_node, $this->header[5].';Koef='.$cells[5]);
    if ($cells[6] <> '') $this->addBet($event_node, $this->header[6].';Koef='.$cells[6]);
    if ($cells[7] <> '') $this->addBet($event_node, $this->header[7].';Koef='.$cells[7]);
    if ($cells[8] <> '') $this->addBet($event_node, $this->header[8].';Koef='.$cells[8]);

    if ($cells[9] <> '') {
      preg_match('/\(([\+\-]*?)(.+?)\)<br\/>(.+?)/iU', $cells[9], $matches);
      if (($matches[1] == '') and ($matches[2] <> '0')) $matches[1] = '+';
      $this->addBet($event_node, $this->header[9].';Value='.$matches[1].$matches[2].';Koef='.$matches[3]);
    }
    if ($cells[10] <> '') {
      preg_match('/\(([\+\-]*?)(.+?)\)<br\/>(.+?)/iU', $cells[10], $matches);
      if (($matches[1] == '') and ($matches[2] <> '0')) $matches[1] = '+';
      $this->addBet($event_node, $this->header[10].';Value='.$matches[1].$matches[2].';Koef='.$matches[3]);
    }
    if ($cells[12] <> '') {
      $value = $cells[11];
      if (!strpos($value, '.')) $value = $value-0.5;
      $this->addBet($event_node, $this->header[12].';Value='.$value.';Koef='.$cells[12]);
    }
    if ($cells[13] <> '') { 
      $value = $cells[11];
      if (!strpos($value, '.')) $value = $value+0.5;
      $this->addBet($event_node, $this->header[13].';Value='.$value.';Koef='.$cells[13]);
    }
  }

  private function extract_main_bets_soccer(&$tournir_node, $html, $sport_sign, $tournir_id) {
    $event_id = extract_property_values(copy_be($html, '<ul', '>', 'rel'), 'rel', '');
    $html = kill_tag_bound($html, 'u');
    $cells = extract_all_tags($html, '<li', '</li>');
    $i = 0;
    foreach($cells as $cell) $cells[$i++] = delete_all($cell, '<', '>', 'li');
    list($day_no, $month_no, $year_no, $hour, $minute) = $this->decode_datetime(str_ireplace('<br>', ' ', $cells[0]));
    list($gamer1_name, $gamer2_name) = explode('<br/>', $cells[2]);
    $event_node = $this->event_create($tournir_node, $event_id, mktime($hour, $minute, 0, $month_no, $day_no, $year_no), $gamer1_name, $gamer2_name);
    if ($cells[3] <> '') $this->addBet($event_node, $this->header[3].';Koef='.$cells[3]);
    if ($cells[4] <> '') $this->addBet($event_node, $this->header[4].';Koef='.$cells[4]);
    if ($cells[5] <> '') $this->addBet($event_node, $this->header[5].';Koef='.$cells[5]);
    if ($cells[6] <> '') $this->addBet($event_node, $this->header[6].';Koef='.$cells[6]);
    if ($cells[7] <> '') $this->addBet($event_node, $this->header[7].';Koef='.$cells[7]);
    if ($cells[8] <> '') $this->addBet($event_node, $this->header[8].';Koef='.$cells[8]);

    if ($cells[9] <> '') {
      preg_match('/\(([\+\-]*?)(.+?)\)<br\/>(.+?)/iU', $cells[9], $matches);
      if (($matches[1] == '') and ($matches[2] <> '0')) $matches[1] = '+';
      $this->addBet($event_node, $this->header[9].';Value='.$matches[1].$matches[2].';Koef='.$matches[3]);
    }
    if ($cells[10] <> '') {
      preg_match('/\(([\+\-]*?)(.+?)\)<br\/>(.+?)/iU', $cells[10], $matches);
      if (($matches[1] == '') and ($matches[2] <> '0')) $matches[1] = '+';
      $this->addBet($event_node, $this->header[10].';Value='.$matches[1].$matches[2].';Koef='.$matches[3]);
    }
    if ($cells[12] <> '') {
      $value = $cells[11];
      if (!strpos($value, '.')) $value = $value-0.5;
      $this->addBet($event_node, $this->header[12].';Value='.$value.';Koef='.$cells[12]);
    }
    if ($cells[13] <> '') { 
      $value = $cells[11];
      if (!strpos($value, '.')) $value = $value+0.5;
      $this->addBet($event_node, $this->header[13].';Value='.$value.';Koef='.$cells[13]);
    }
  }
  
  private function extract_extra_bets(&$tournir_node, $html, $sport_sign, $tournir_id) {
    $html = str_ireplace('<li><h2>', '<li class="extra"><h2>', $html);
    $html = numbering_tag($html, 'li');
    $table_rows = extract_all_numbered_tags($html, 'li', 'extra');
    foreach($table_rows as $row) {
      $row = kill_property($row, 'TagNo');
      $event_id = extract_property_values(copy_be($html, '<ul', '>', 'rel'), 'rel', '');
      $event_node = $this->event_find($tournir_node, $event_id);
      $phrase = copy_be($row, '<h2', '</h2>');
      $phrase = copy_between($phrase, '>', '<');
      $section_node = $this->findSection($sport_sign, $phrase);
      if (!(string)$section_node['Ignore']) {
        $bets = extract_all_tags($row, '<li', '</li>', 'rel');
        foreach($bets as $bet) {
          list($label, $koef) = $this->extract_label_koef($bet);
          $label = str_ireplace((string)$event_node['Gamer1_Name'], 'Gamer1', $label);
          $label = str_ireplace((string)$event_node['Gamer2_Name'], 'Gamer2', $label);
          $phrase_node = $this->findPhrase($sport_sign, $phrase, $label);
          if (!$phrase_node['Ignore']) {
            $this->addBet($event_node, (string)$phrase_node['BetKind'].';Koef='.$koef);
          }
        }
      }
    }
  }
    
  private function extract_events(&$tournir_node, $html, $sport_sign, $tournir_id) {
    $html = copy_be($html, '<table', '</table>', 'class=date');
    $html = kill_space($html);
    $tbodies = extract_all_tags($html, '<tbody', '</tbody>');
    foreach($tbodies as $tbody) {
      $tbody_class = extract_property_values(copy_be($tbody, '<', '>'), 'class', '');
      if ($tbody_class == 'date') {
        ($)$event_date = $this->decode_date($tbody);
      } else if ($tbody_class == 'chead') {
        $this->extract_header($sport_sign, $tbody);
      } else if ($tbody_class == 'line') {
        if ($sport_sign == 'tennis') {
          $this->extract_main_bets_tennis($tournir_node, $tbody, $sport_sign, $tournir_id);
        } elseif ($sport_sign == 'soccer') {
          $this->extract_main_bets_soccer($tournir_node, $tbody, $sport_sign, $tournir_id);
        }
      }
    }
  }

  public function getEvents($sport_id, $tournir_id, $tournir_url) {
    $xml = parent::getEvents($sport_id, $tournir_id, $tournir_url);
    $tournir_node = $xml->addChild('Events');
    $file_name = $this->league_path.$tournir_id;
    $rnd = rand(1000000000, 2000000000);
    $url = $this->host."/bets/bets2.php?rnd=$rnd";
    $referer = $this->host.(string)$this->sport_node['Url'];
    $post_hash['time'] = 1;
    $post_hash['gcheck'] = 9;
    $post_hash['line_id[]'] = $tournir_id;
    
    $html = download_or_load($this->debug, $file_name.".html", $url, "POST", $referer, $post_hash);
    $this->extract_events($tournir_node, win1251_to_utf8($html), (string)$this->sport_node['Sign'], $tournir_id);

    if ($this->debug) file_put_contents($file_name.".xml", $xml->asXML());
    return $xml;
  }

}  
?>