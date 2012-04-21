notes = """
tiny world rts

victory: destruction of enemy base

aim for games < 10min

units move quickly

units auto gen 1 every 15 seconds
max 15 people
start with 1 hero; no respawn

no buildings
wood for bridges
"""

game = {}
document.game = game

vk =
  w: 87
  a: 65
  s: 83
  d: 68

keyBindings = {}
game.keyBindings = keyBindings

keys = {}
game.keys = keys

mouse =
  x: 0
  y: 0
  buttons: {}

game.mouse = mouse

requestAnimFrame =
    window.requestAnimationFrame       ||
    window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame    ||
    window.oRequestAnimationFrame      ||
    window.msRequestAnimationFrame     ||
    (callback) ->
        window.setTimeout callback, 1000 / 60


game.start = new Date
game.start = game.start.toISOString()

console.log "starting: #{game.start}"

wait = (milliseconds, func) -> setTimeout func, milliseconds

mainCanvas = document.getElementById "mainCanvas"
mapCanvas = document.getElementById "mapCanvas"

if mainCanvas.getContext
  ctx = mainCanvas.getContext '2d'
  ctx.font = "32px Helvetica, sans-serif"

if mapCanvas.getContext
  mapCtx = mapCanvas.getContext '2d'

getDelta = ->
  now = Date.now()
  game.lastTick ?= now
  r = now - game.lastTick
  game.lastTick = now
  return r

logFPS = (dt) ->
  game.fps = (1000 / dt).toFixed(0)

update = (dt) ->
  logFPS(dt)

  # handle keys
  for key, pressed of keys
    if pressed
      keyBindings[key]? dt


draw = (dt) ->
  drawWorld dt
  ctx.fillStyle = "rgb(255,255,255)"
  ctx.fillText "hello", 500, 50

drawWorld = (dt) ->
  world = game.state.world
  tileSize = world.tileSize

  if world.mapChanged
    world.mapChanged = 0

    mapCtx.fillStyle = "rgba(255,255,255, 0.4)"
    mapCtx.fillRect 0, 0, mapCanvas.width, mapCanvas.height

    for x in [0...world.width]
      for y in [0...world.height]
        tile = world.map[x + y * world.width]
        switch tile
          when 0
            mapCtx.fillStyle = "rgb(0,0,200)"
          when 1
            mapCtx.fillStyle = "rgb(200,200,0)"
          when 2
            mapCtx.fillStyle = "rgb(200, 100, 0)"
        xPos = x * tileSize + world.offsetX
        yPos = y * tileSize + world.offsetY

        mapCtx.fillRect xPos, yPos, tileSize, tileSize

    ctx.drawImage(mapCanvas, 0, 0)


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

mouseEvent = (e) ->
  coords = mainCanvas.relMouseCoords e
  mouse.x = coords.x
  mouse.y = coords.y
  switch e.type
    when "mouseup"
      mouse.buttons[e.button] = 0
    when "mousedown"
      mouse.buttons[e.button] = 1
    when "mousemove"
      ;

keyDown = (e) ->
  e ?= window.event
  keyCode = e.keyCode
  keys[keyCode] = 1


keyUp = (e) ->
  e?= window.event
  keyCode = e.keyCode
  keys[keyCode] = 0

# register event handlers
document.onkeydown = keyDown
document.onkeyup = keyUp
mainCanvas.onmouseup = mouseEvent
mainCanvas.onmousedown = mouseEvent
mainCanvas.onmousemove = mouseEvent
mainCanvas.oncontextmenu = -> false

world = 
  offsetX: 0
  offsetY: 0
  stepX: 1
  stepY: 1
  tileSize: 64
  height: 5
  width: 5
  mapChanged: true
  map: [
    0,1,1,1,0
    0,1,2,1,0
    0,1,1,1,0
    0,0,0,1,0
    0,0,0,1,0
  ]



scrollWorld = (direction, dt) ->
  world = game.state.world
  world.mapChanged = true
  switch direction
    when "up"
      step = Math.floor(dt * world.stepY)
      world.offsetY -= step
    when "down"
      step = Math.floor(dt * world.stepY)
      world.offsetY += step
    when "left"
      step = Math.floor(dt * world.stepX)
      world.offsetX -= step
    when "right"
      step = Math.floor(dt * world.stepX)
      world.offsetX += step



keyBindings[vk.w] = (dt) ->
  scrollWorld "up", dt

keyBindings[vk.a] = (dt) ->
  scrollWorld "left", dt

keyBindings[vk.s] = (dt) ->
  scrollWorld "down", dt

keyBindings[vk.d] = (dt) ->
  scrollWorld "right", dt


mainGameState = {
  update,
  draw,
  world,
}

game.state = mainGameState

game.loop = ->
  dt = getDelta()
  game.state.update dt
  game.state.draw dt
  requestAnimFrame game.loop

requestAnimFrame game.loop

setInterval ->
  document.getElementById('fps').innerHTML = game.fps
, 1000

