
<!DOCTYPE HTML>
<html lang="en-GB">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <title>Detecting Adblock (inline)</title>
  <style type="text/css">
    body {
      background: #f8f8f8;
      font-family: "Segoe UI", Arial, Helvetica, sans-serif;
      font-weight: lighter;
      color: #333;
      padding: 2em;
    }
    .notblocked {
      display: block;
    }
    .blocked {
      display: none;
    }
    .adblock .notblocked {
      display: none;
    }
    .adblock .blocked {
      display: block;
    }
  </style>
</head>
<body>
<h1>Detecting AdBlock</h1>

<p class="notblocked">AdBlock is disabled.</p>

<p class="blocked">AdBlock is enabled.</p>

<script>
(function(){
  var test = document.createElement('div');
  test.innerHTML = '&nbsp;';
  test.className = 'adsbox';
  document.body.appendChild(test);
  window.setTimeout(function() {
    if (test.offsetHeight === 0) {
      document.body.classList.add('adblock');
    }
    test.remove();
  }, 100);
})();
</script>
</body>
</html>