<?php
  require "libs/Download.php";
  require "libs/GvStrings.php";
  require "libs/GvHtmlSrv.php";
  $Booker = 'betby';
  $debug = $_GET['debug'];
  $Lines = "lines/$Booker/";
  
  // ������� ������ ����� c ���������
  if (!$debug) {
    $FileName = $Lines . 'bets.html';
    if (file_exists($FileName)) {
      $CurDtTm = getdate();
      $Seconds = $CurDtTm['0']-filectime($FileName);
      if ($Seconds > 5*60) {
        unlink($Lines . "league.html");
        unlink($Lines . "bets.html");
      }
    }
  }

function extract_league($Html) {
  $Html = copy_be($Html, '<form ', '</form>', '"frmTurnirs"');
  $Html = extract_tags($Html, '<input', '>', "\r\n", 'id="sport_', 'name="turnir_'); 
  $Html = delete_all($Html, '<input', '>', 'turnir_2_');   // �������
  $Html = delete_all($Html, '<input', '>', 'turnir_12_');  // ����
  $Html = delete_all($Html, '<input', '>', 'turnir_254_'); // �������
  $Html = delete_all($Html, '<input', '>', 'turnir_255_'); // ������ ���� ������
  $Html = delete_all($Html, '<input', '>', 'turnir_6_');   // ������
  $Html = extract_property_values($Html, 'name', ';');
  return $Html;  
}

  // �������� �������� ��������
  $FileName = $Lines . "league.html";
  if (!file_exists($FileName)) {
    $Html = download("http://bet.by/lines_set_turnir.php?period=all", "GET", "http://bet.by/");
    file_put_contents($FileName, $Html);
  } else {
    $Html = file_get_contents($FileName);
  }
  $LeagueList = extract_league($Html);
  if ($debug) file_put_contents($Lines . "league.txt", $LeagueList);
  
function extract_bet($Html) {
  $Html = kill_tag_bound($Html, 'b|a|font|img');
  $Html = str_ireplace('\'style', '\' style', $Html);
  $Html = str_ireplace('nowrap', '', $Html);
  $Html = kill_space($Html);
  $Html = numbering_tag($Html, 'table');
  $Html = extract_numbered_tags($Html, 'table', "\r\n", 'width=\'70%\'');
  $Html = kill_property($Html, "onmousemove|onmouseout|valign|align|class|style|height|width|cellpadding|cellspacing|border");
  $Html = kill_property($Html, 'TagNo');
  // ���������� ������� � ���� � ����������
  for ($i=2; $i<20; $i++) {
    $Html = str_ireplace(" colspan='$i'", " colspan=$i", $Html);
    $Html = str_ireplace(" colspan=\"$i\"", " colspan=$i", $Html);
  }
  $Html = str_ireplace('<th colspan=6><table><tr>', '', $Html);
  $Html = str_ireplace('</tr></table></th>', '', $Html);
  $Html = str_ireplace('<td colspan=6><table><tr>', '', $Html);
  $Html = str_ireplace('<td colspan=15><table><tr>', '', $Html);
  $Html = str_ireplace('</tr></table></td>', '', $Html);
  // ������� �����������
  $Html = replace_all_contain($Html, '<tr>', '</tr>', '',
          '����������� � �������:|����');
          
  $Html = replace_all_contain($Html, '<span>', '</span>', '',
          '���������');
  $Html = str_ireplace('>--<', '><', $Html);
  // ������ ����� � ���� ������
  $Html = str_ireplace('><span>', '>', $Html);
  $Html = str_ireplace('<span>', '. ', $Html);
  $Html = str_ireplace('</span>', '', $Html);
  return $Html;
}

  // �������� �������� ������
  $FileName = $Lines . "bets.html";
  if (!file_exists($FileName)) {
    $PostData['txtQuery'] = $LeagueList;
    $PostData['period'] = 'all';
    $PostData['stavka'] = 1;
    $turnirs = explode(';', $LeagueList);
    foreach ($turnirs as $turnir) {
      $PostData[$turnir] = 'on';
    }
    $Html = download("http://bet.by/lines.php", "POST", "http://bet.by/lines_set_turnir.php?period=all", $PostData);
    file_put_contents($FileName, $Html);
  } else {
    $Html = file_get_contents($FileName);
  }
  $Result = extract_bet($Html);
  if ($debug) file_put_contents($Lines . 'bets.txt.html', $Result);
  if ($debug) file_put_contents($Lines . 'bets.txt', $Result);

  print ($Result);
?>

