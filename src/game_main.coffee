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

world =
  offsetX: 0
  offsetY: 0
  stepX: 1
  stepY: 1
  tileSize: 64
  height: 40
  width: 40
  score: 0
  selecting: false
  mapChanged: true
  actors: []
  map: [
    2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,2,2,2,2,2,2,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
  ]

miniMapCanvas = document.createElement 'canvas'
miniMapCanvas.zoom = 2
miniMapCanvas.setAttribute 'width', world.width * miniMapCanvas.zoom
miniMapCanvas.setAttribute 'height', world.height * miniMapCanvas.zoom

if miniMapCanvas.getContext
  miniMapCtx = miniMapCanvas.getContext '2d'
  miniMapCtx.fillStyle = "rgb(230,230,130)"
  miniMapCtx.fillRect 0, 0, miniMapCanvas.width, miniMapCanvas.height

# create miniMap
for x in [0...world.width]
  for y in [0...world.height]
    tile = world.map[x + y * world.width]
    switch tile
      when 0 then miniMapCtx.fillStyle = 'rgb(0,0,255)'
      when 1 then miniMapCtx.fillStyle = 'rgb(255,255,0)'
      when 2 then miniMapCtx.fillStyle = 'rgb(0,255,0)'
    miniMapCtx.fillRect x*miniMapCanvas.zoom,
      y*miniMapCanvas.zoom,
      miniMapCanvas.zoom,
      miniMapCanvas.zoom


vk =
  w: 87
  a: 65
  s: 83
  d: 68

vm =
  left: 1
  middle: 2
  right: 3

keyBindings = {}
game.keyBindings = keyBindings

keys = {}
game.keys = keys

mouse =
  x: 0
  y: 0
  buttons: {}
  selecting: false

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

  if mouse.buttons[vm.left]
    if !mouse.selecting
      # start selecting
      mouse.selecting = true
      mouse.fromX = mouse.x
      mouse.fromY = mouse.y
    else
      ;
  else
    if mouse.selecting
      mouse.selecting = false
      # select stuff
      console.log 'select'

  if mouse.buttons[vm.right]
    mouse.buttons[vm.right] = 0
    console.log 'action'


draw = (dt) ->
  drawWorld dt
  drawActors dt
  drawSelection dt
  drawHub dt

drawHub = (dt) ->
  world = game.state.world
  ctx.fillStyle = "rgb(130,130,130)"
  ctx.fillRect 0, 0, 200, 40
  ctx.fillStyle = "rgb(230,230,230)"
  ctx.fillText "Score: #{game.state.world.score}", 10, 30

  miniMapOffsetX = mainCanvas.width - miniMapCanvas.width
  miniMapOffsetY = mainCanvas.height - miniMapCanvas.height
  ctx.drawImage miniMapCanvas, miniMapOffsetX, miniMapOffsetY
  # draw view outline
  ctx.strokeStyle = "rgb(255,0,0)"
  ctx.lineWidth = 2
  viewLeft = miniMapOffsetX - world.offsetX / world.tileSize * miniMapCanvas.zoom
  viewTop = miniMapOffsetY - world.offsetY / world.tileSize * miniMapCanvas.zoom
  viewWidth = mainCanvas.width / world.tileSize * miniMapCanvas.zoom
  viewHeight = mainCanvas.height / world.tileSize * miniMapCanvas.zoom
  ctx.strokeRect viewLeft, viewTop, viewWidth, viewHeight

drawSelection = (dt) ->
  if mouse.selecting
    w = mouse.x - mouse.fromX
    h = mouse.y - mouse.fromY
    ctx.fillStyle = "rgba(255,0,0,0.2)"
    ctx.fillRect mouse.fromX, mouse.fromY, w, h
    ctx.strokeStyle = "rgb(255,255,255)"
    ctx.lineWidth = 2
    ctx.strokeRect mouse.fromX, mouse.fromY, w, h

drawActors = (dt) ->
  world = game.state.world
  for actor in world.actors
    switch actor.selected
      when true then ctx.fillStyle = "rgb(230,200,200)"
      when false then ctx.fillStyle = "rgb(200,200,200)"
    x = actor.x + world.offsetX
    y = actor.y + world.offsetY
    ctx.fillRect x, y, world.tileSize, world.tileSize

drawWorld = (dt) ->
  world = game.state.world
  tileSize = world.tileSize

  if world.mapChanged
    world.mapChanged = 0

    mapCtx.fillStyle = "rgba(145,145,225, 0.4)"
    mapCtx.fillRect 0, 0, mapCanvas.width, mapCanvas.height

    for x in [0...world.width]
      for y in [0...world.height]
        tile = world.map[x + y * world.width]
        xPos = x * tileSize + world.offsetX
        yPos = y * tileSize + world.offsetY
        switch tile
          when 0
            mapCtx.fillStyle = "rgb(20,20,160)"
            mapCtx.fillRect xPos, yPos, tileSize, tileSize
          when 1
            mapCtx.fillStyle = "rgb(200,200,40)"
            mapCtx.fillRect xPos, yPos, tileSize, tileSize
          when 2
            mapCtx.fillStyle = "rgb(90, 150, 10)"
            mapCtx.fillRect xPos, yPos, tileSize, tileSize


  ctx.drawImage mapCanvas, 0, 0 


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
      mouse.buttons[e.which] = 0
    when "mousedown"
      mouse.buttons[e.which] = 1
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

document.onmouseup = mouseEvent
document.onmousedown = mouseEvent
document.onmousemove = mouseEvent

mainCanvas.oncontextmenu = -> false


world.maxOffsetX = mainCanvas.width / 2
world.minOffsetX = (mainCanvas.width / 2) + world.width * world.tileSize * -1
world.maxOffsetY = mainCanvas.height / 2
world.minOffsetY = (mainCanvas.height / 2) + world.height * world.tileSize * -1

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


  world.offsetX = world.maxOffsetX if world.offsetX > world.maxOffsetX
  world.offsetX = world.minOffsetX if world.offsetX < world.minOffsetX
  world.offsetY = world.maxOffsetY if world.offsetY > world.maxOffsetY
  world.offsetY = world.minOffsetY if world.offsetY < world.minOffsetY



keyBindings[vk.w] = (dt) ->
  scrollWorld "down", dt

keyBindings[vk.a] = (dt) ->
  scrollWorld "right", dt

keyBindings[vk.s] = (dt) ->
  scrollWorld "up", dt

keyBindings[vk.d] = (dt) ->
  scrollWorld "left", dt


mainGameState = {
  update,
  draw,
  world,
}

world.actors.push
  x: 0
  y: 0
  selected: false

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

