notes = """
tiny world rts

victory: destruction of enemy base

aim for games < 10min

units move quickly

units auto gen 1 every 15 seconds
max 15 people
start with 1 hero; no respawn

limited buildings
no repair of buildings
"""

requestAnimFrame =
    window.requestAnimationFrame       ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame    ||
    window.oRequestAnimationFrame      ||
    window.msRequestAnimationFrame     ||
    (callback) ->
        window.setTimeout callback, 1000 / 60

game = {}
document.game = game
game.start = new Date
game.start = game.start.toISOString()

console.log "starting: #{game.start}"

wait = (milliseconds, func) -> setTimeout func, milliseconds

canvas = document.getElementById "mainCanvas"

if canvas.getContext
  ctx = canvas.getContext '2d'

getDelta = ->
  now = Date.now()
  game.lastTick ?= now
  r = now - game.lastTick
  game.lastTick = now
  return r

logFPS = ->
  game.fps = (1000 / dt).toFixed(0)

update = ->
  dt = getDelta()
  logFPS(dt)

draw = ->
  ctx.fillStyle = 'rgb(255,0,0)'
  ctx.fillRect 10, 10, 55, 50

  ctx.fillStyle = "rgba(0,0,200, 0.5)"
  ctx.fillRect 30, 30, 55, 50

  ctx.font = "32px Helvetica, sans-serif"
  ctx.fillText("Test", 100, 100);

relMouseCoords = (e) ->
  if e.pageX or e.pageY
    x = e.pageX
    y = e.pageY
  else
    x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
    y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop
  x -= @offsetLeft
  y -= @offsetTop
  return {x, y}

HTMLCanvasElement.prototype.relMouseCoords = relMouseCoords

mouseDown = (e) ->
  coords = canvas.relMouseCoords e
  x = coords.x
  y = coords.y
  ctx.fillRect x, y, 55, 50

keyDown = (e) ->
  e ?= window.event

keyUp = (e) ->
  e?= window.event

document.onkeydown = keyDown
document.onkeyup = keyUp
canvas.onmousedown = mouseDown

mainGameState = { update, draw }

game.state = mainGameState


game.loop = ->
  game.state.update()
  game.state.draw()
  requestAnimFrame game.loop

requestAnimFrame game.loop

setInterval ->
  document.getElementById('fps').innerHTML = game.fps
, 1000

