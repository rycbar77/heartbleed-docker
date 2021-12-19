<html>

<body>
  <form name="form" action="" method="post">
    <input type="text" name="secret">
  </form>

  <?php
  $secret = $_POST['secret'];
  echo $secret;
  echo PHP_EOL;
  echo md5($secret);
  echo PHP_EOL;
  echo "leaked!!!!" . $secret;
  ?>
</body>

</html>