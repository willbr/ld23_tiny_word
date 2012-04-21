(function() {
  var canvas, ctx, draw, game, getDelta, keyDown, keyUp, logFPS, mainGameState, mouseDown, notes, relMouseCoords, requestAnimFrame, update, wait;

  notes = "tiny world rts\n\nvictory: destruction of enemy base\n\naim for games < 10min\n\nunits move quickly\n\nunits auto gen 1 every 15 seconds\nmax 15 people\nstart with 1 hero; no respawn\n\nlimited buildings\nno repair of buildings";

  requestAnimFrame = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback) {
    return window.setTimeout(callback, 1000 / 60);
  };

  game = {};

  document.game = game;

  game.start = new Date;

  game.start = game.start.toISOString();

  console.log("starting: " + game.start);

  wait = function(milliseconds, func) {
    return setTimeout(func, milliseconds);
  };

  canvas = document.getElementById("mainCanvas");

  if (canvas.getContext) ctx = canvas.getContext('2d');

  getDelta = function() {
    var now, r;
    now = Date.now();
    if (game.lastTick == null) game.lastTick = now;
    r = now - game.lastTick;
    game.lastTick = now;
    return r;
  };

  logFPS = function(dt) {
    return game.fps = (1000 / dt).toFixed(0);
  };

  update = function() {
    var dt;
    dt = getDelta();
    return logFPS(dt);
  };

  draw = function() {
    ctx.fillStyle = 'rgb(255,0,0)';
    ctx.fillRect(10, 10, 55, 50);
    ctx.fillStyle = "rgba(0,0,200, 0.5)";
    ctx.fillRect(30, 30, 55, 50);
    ctx.font = "32px Helvetica, sans-serif";
    return ctx.fillText("Test", 100, 100);
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

  mainGameState = {
    update: update,
    draw: draw
  };

  game.state = mainGameState;

  game.loop = function() {
    game.state.update();
    game.state.draw();
    return requestAnimFrame(game.loop);
  };

  requestAnimFrame(game.loop);

  setInterval(function() {
    return document.getElementById('fps').innerHTML = game.fps;
  }, 1000);

}).call(this);
