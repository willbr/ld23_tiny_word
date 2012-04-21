(function() {
  var canvas, ctx, draw, keyDown, keyUp, mouseDown, notes, relMouseCoords, start, wait;

  notes = "tiny world rts\n\nvictory: destruction of enemy base\n\naim for games < 10min\n\nunits move quickly\n\nunits auto gen 1 every 15 seconds\nmax 15 people\nstart with 1 hero; no respawn\n\nlimited buildings\nno repair of buildings";

  start = new Date;

  start = start.toISOString();

  console.log("starting: " + start);

  wait = function(milliseconds, func) {
    return setTimeout(func, milliseconds);
  };

  canvas = document.getElementById("mainCanvas");

  if (canvas.getContext) ctx = canvas.getContext('2d');

  draw = function() {
    ctx.fillStyle = 'rgb(255,0,0)';
    ctx.fillRect(10, 10, 55, 50);
    ctx.fillStyle = "rgba(0,0,200, 0.5)";
    return ctx.fillRect(30, 30, 55, 50);
  };

  relMouseCoords = function(e) {
    var x, y;
    if (e.pageX || e.pageY) {
      x = e.pageX;
      y = e.pageY;
    } else {
      x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
      y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
    }
    x -= this.offsetLeft;
    y -= this.offsetTop;
    return {
      x: x,
      y: y
    };
  };

  HTMLCanvasElement.prototype.relMouseCoords = relMouseCoords;

  mouseDown = function(e) {
    var coords, x, y;
    coords = canvas.relMouseCoords(e);
    x = coords.x;
    y = coords.y;
    return ctx.fillRect(x, y, 55, 50);
  };

  keyDown = function(e) {
    return e != null ? e : e = window.event;
  };

  keyUp = function(e) {
    return e != null ? e : e = window.event;
  };

  document.onkeydown = keyDown;

  document.onkeyup = keyUp;

  canvas.onmousedown = mouseDown;

  draw();

}).call(this);
