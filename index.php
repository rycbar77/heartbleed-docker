<html>
  <body>
    <form name="form" action="" method="post">
      <input type="text" name="secret">
    </form>

    <?php
      echo md5($_POST['secret']);
    ?>
  </body>
</html>
