<div class="maincontent" id="servicecontent">
  <div id="headline_item">
    <div class="text">
      <h1 class="content_headline">Возврат, аннуляция</h1>
    </div>
  </div>

  <div class="content" id="payment">
    <div id="head">
      <img class="row-left" alt="" src="/assets/otto-by/images/service/delivery/delivery.jpg">
      <div class="row-right">
        <div class="categories">
          <p>Возврат всего полученного в посылке товара или части ее вложения производится в любом почтовом отделении в 
             течение 5 рабочих дней, следующих за датой получения посылки.</p>
          <p>Зачисление денег на виртуальный счет клиента производится в день получения заявления <strong>и возвращенного товара</strong>.</p>
          <p>Возврат  денежных средств&nbsp;- в течение 7 рабочих дней от даты получения заявления <strong>и товара</strong>.</p>
        </div>
      </div>
      <div class="clear_both"></div>
    </div>

<?php
  $fpath = $template_path . $_GET['path'] . '/';
  $files = scandir($fpath);
  foreach($files as $f) {
    if ((substr($f, 0, 4) == 'faq_') and (substr($f, -4) == '.inc')) {
      include $fpath . $f;
    }
  }
  ?>

  </div>
</div>