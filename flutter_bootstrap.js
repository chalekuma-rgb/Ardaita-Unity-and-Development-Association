// Flutter bootstrap loader
window.addEventListener('load', function() {
  var script = document.createElement('script');
  script.src = "main.dart.js";
  script.defer = true;
  document.body.appendChild(script);
});
