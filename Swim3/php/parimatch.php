<?php
  require "libs/Download.php";
  require "libs/GvStrings.php";
  require "libs/GvHtmlSrv.php";
  $debug = $_GET['debug'];
  $Booker = 'parimatch';
  $Lines = "lines/$Booker/";

function extract_league($Html) {
  $Html = extract_tags($Html, '<input type="checkbox" name="hd', '">', ","); 
  $Html = delete_all($Html, '<', 'value="');
  $Html = str_replace('">', '', $Html);
  return $Html;  
}
  
  // �������� �������� ��������
  if ($debug) {
    $FileName = $Lines . 'league.html';
    if (!file_exists($FileName)) {
      $Html = download_page('http://www.parimatch.com/line.html?id=0', "GET");
      file_put_contents($FileName, $Html);
    } else {
      $Html = file_get_contents($FileName);
    }
  } else {
    $Html = download_page('http://www.parimatch.com/line.html?id=0', "GET");
  }
  $Leagues = extract_league($Html);
  if ($debug) file_put_contents($Lines . 'league.txt', $Leagues);

function extract_bet($Html) {
  $Html = copy_be($Html, '<form name=f1', '</form>', '����');
  $Html = kill_space($Html);
  $Html = kill_tag($Html, 'script');
  $Html = kill_tag_bound($Html, 'b|a|tbody|small|colgroup');
  
  // <!-- ������� �������� � ���������� � ���������� �������� -->
  $Html = str_ireplace('<span class=tr>1</span>', '', $Html);
  $Html = delete_all($Html, '<tr>', '</tr>', '<span class=tr>');
  $Html = delete_all($Html, '<span class=n>', '</span>');
  //  <!-- ������� ������ � �������� -->
  $Html = delete_all($Html, '<table ', '</table>', '<input ');
  //  <!-- �������� IMG � ����������� �� igif ��� ������������ �������� -->
  $Html = replace_all($Html, '<img ', '>', "igif");
  //  <!-- ������� ����� ������������ � ������� -->
  $Html = replace_all($Html, '>(', ')', '>');
  //  <!-- ������� ���������� -->
  $Html = delete_all($Html, "<div ", "</div", "����������");
  $Html = kill_property($Html, 'width|border');

  $Html = replace_all_contain($Html, '<tr', '</tr>', '', 
          '>�������|'.
          '>�����|'.
          '>����|'.
          '>�/�|'.
          '>���.');
  return $Html;
}

  // �������� �������� ������
  if ($Leagues != '') {
    $PostData[] = 'hd=' . $Leagues;
    $PostData[] = 'filter=';
    $PostData[] = 'linedate=';
    $PostData[] = 'ltype=';

    if ($debug) {
      $FileName = $Lines . "bets.html";
      if (!file_exists($FileName)) {
        $Html = download_page("http://www.parimatch.com/bet.html", "GET", "http://www.parimatch.com/line.html?id=0", implode('&', $PostData), true);
        file_put_contents($FileName, $Html);
      } else {
        $Html = file_get_contents($FileName);
      }
    } else {  
      $Html = download_page("http://www.parimatch.com/bet.html", "GET", "http://www.parimatch.com/line.html?id=0", implode('&', $PostData));
    }   
    $Result = extract_bet($Html);
    if ($debug) file_put_contents($Lines . 'bets.txt', $Result);
  }
  
  print ($Result);
?>
