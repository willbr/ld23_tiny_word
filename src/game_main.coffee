todo = """
world.actorsSelected = true
path finding
atacking
build bridges
ai
"""

notes = """
tiny world rts

victory: destruction of enemy base

aim for games < 10min

units move quickly

units auto gen 1 every 15 seconds
max 15 people
start with 1 unit

no buildings
"""

vk =
  w: 87
  a: 65
  s: 83
  d: 68

vm =
  left: 1
  middle: 2
  right: 3

Point = (x, y) -> {x, y}

Actor = (x,y) ->
    pos: Point x * world.tileSize, y * world.tileSize
    selected:false
    path: []

toWorld = (p) ->
  world = game.state.world
  Point p.x + world.offset.x, p.y + world.offset.y

game = {}
document.game = game

world =
  debug:
    points: []
  offset: Point 0, 0
  stepX: 1
  stepY: 1
  tileSize: 64
  height: 40
  width: 40
  score: 0
  mapChanged: true
  actors: []
  actorsSelected: []
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


keyBindings = {}
game.keyBindings = keyBindings

keys = {}
game.keys = keys

mouse =
  pos: Point 0,0
  from: Point 0,0
  panPos: Point 0, 0
  panning: false
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


inside = (p, p1, p2) ->
  if (p.x > Math.min(p1.x, p2.x) and p.x < Math.max(p1.x, p2.x)) and (p.y > Math.min(p1.y, p2.y) and p.y < Math.max(p1.y, p2.y))
    return true
  else
    return false

collide = (ap1, ap2, bp1, bp2) ->
  if inside(ap1, bp1, bp2) or inside(ap2, bp1, bp2) or inside(bp1, ap1, ap2) or inside(bp2, ap1, ap2)
    return true
  else
    return false

update = (dt) ->
  world = game.state.world
  logFPS(dt)

  # handle keys
  for key, pressed of keys
    if pressed
      keyBindings[key]? dt

  if mouse.buttons[vm.left]
    if !mouse.selecting
      # start selecting
      mouse.selecting = true
      mouse.from = Point mouse.pos.x, mouse.pos.y
    else
      ;
  else
    if mouse.selecting
      world.debug.points = []
      mouse.selecting = false
      world.actorsSelected = []
      # select stuff
      for actor in world.actors
        ap1 = Point actor.pos.x, actor.pos.y
        ap1.x += world.offset.x
        ap1.y += world.offset.y
        ap2 = Point ap1.x + world.tileSize, ap1.y + world.tileSize
        if collide(ap1, ap2, mouse.from, mouse.pos)
          actor.selected = true
          world.actorsSelected.push actor
          world.debug.points.push ap1
          world.debug.points.push ap2
          world.debug.points.push mouse.from
          world.debug.points.push mouse.pos
        else
          actor.selected = false

  if mouse.buttons[vm.right]
    mouse.buttons[vm.right] = 0
    console.log 'action'
    if world.actorsSelected.length > 0
      #move actors
      console.log 'move'

  if mouse.buttons[vm.middle]
    if mouse.panning
      dx = mouse.pos.x - mouse.panPos.x
      dy = mouse.pos.y - mouse.panPos.y
      world.offset.x += dx
      world.offset.y += dy
      clipWorldOffset()
      world.mapChanged = true
    else
      mouse.panning = true
    mouse.panPos.x = mouse.pos.x; mouse.panPos.y = mouse.pos.y
  else
    mouse.panning = false

draw = (dt) ->
  drawWorld dt
  drawActors dt
  drawSelection dt
  drawHud dt
  # drawDebug dt

drawActors = (dt) ->
  world = game.state.world
  for actor in world.actors
    switch actor.selected
      when true then ctx.fillStyle = "rgb(255,150,150)"
      when false then ctx.fillStyle = "rgb(200,200,200)"
    x = actor.pos.x + world.offset.x
    y = actor.pos.y + world.offset.y
    ctx.fillRect x, y, world.tileSize, world.tileSize

drawDebug = (dt) ->
  world = game.state.world
  for p in world.debug.points
    ctx.fillStyle = "rgb(255,0,0)"
    ctx.fillRect p.x - 4, p.y - 4, 8, 8

drawHud = (dt) ->
  world = game.state.world
  ctx.fillStyle = "rgb(130,130,130)"
  #ctx.fillRect 0, 0, 200, 40
  ctx.fillStyle = "rgb(230,230,230)"
  #ctx.fillText "Score: #{game.state.world.score}", 10, 30

  miniMapOffset = Point mainCanvas.width - miniMapCanvas.width, mainCanvas.height - miniMapCanvas.height
  ctx.drawImage miniMapCanvas, miniMapOffset.x, miniMapOffset.y
  for actor in world.actors
    switch actor.selected
      when true then ctx.fillStyle = "rgb(255,50,50)"
      when false then ctx.fillStyle = "rgb(200,200,200)"
    x = actor.pos.x / world.tileSize
    y = actor.pos.y / world.tileSize
    x *= miniMapCanvas.zoom
    y *= miniMapCanvas.zoom
    x += miniMapOffset.x
    y += miniMapOffset.y
    ctx.fillRect x, y, 4, 4
  # draw screen outline
  ctx.strokeStyle = "rgb(255,0,0)"
  ctx.lineWidth = 2
  viewLeft = miniMapOffset.x - world.offset.x / world.tileSize * miniMapCanvas.zoom
  viewTop = miniMapOffset.y - world.offset.y / world.tileSize * miniMapCanvas.zoom
  viewWidth = mainCanvas.width / world.tileSize * miniMapCanvas.zoom
  viewHeight = mainCanvas.height / world.tileSize * miniMapCanvas.zoom
  ctx.strokeRect viewLeft, viewTop, viewWidth, viewHeight

drawSelection = (dt) ->
  if mouse.selecting
    w = mouse.pos.x - mouse.from.x
    h = mouse.pos.y - mouse.from.y
    ctx.fillStyle = "rgba(255,0,0,0.2)"
    ctx.fillRect mouse.from.x, mouse.from.y, w, h
    ctx.strokeStyle = "rgb(255,255,255)"
    ctx.lineWidth = 2
    ctx.strokeRect mouse.from.x, mouse.from.y, w, h


drawWorld = (dt) ->
  world = game.state.world
  tileSize = world.tileSize

  if world.mapChanged
    world.mapChanged = 0

    mapCtx.fillStyle = "rgbx(145,145,225)"
    mapCtx.fillRect 0, 0, mapCanvas.width, mapCanvas.height

    for x in [0...world.width]
      for y in [0...world.height]
        tile = world.map[x + y * world.width]
        xPos = x * tileSize + world.offset.x
        yPos = y * tileSize + world.offset.y
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
  mouse.pos = mainCanvas.relMouseCoords e
  switch e.type
    when "mouseup"
      mouse.buttons[e.which] = 0
    when "mousedown"
      mouse.buttons[e.which] = 1

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
      world.offset.y -= step
    when "down"
      step = Math.floor(dt * world.stepY)
      world.offset.y += step
    when "left"
      step = Math.floor(dt * world.stepX)
      world.offset.x -= step
    when "right"
      step = Math.floor(dt * world.stepX)
      world.offset.x += step
  clipWorldOffset()


clipWorldOffset = ->
  world = game.state.world
  world.offset.x = world.maxOffsetX if world.offset.x > world.maxOffsetX
  world.offset.x = world.minOffsetX if world.offset.x < world.minOffsetX
  world.offset.y = world.maxOffsetY if world.offset.y > world.maxOffsetY
  world.offset.y = world.minOffsetY if world.offset.y < world.minOffsetY


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

world.actors.push Actor 0, 0
world.actors.push Actor 4, 4
world.actors.push Actor 8, 6
world.actors.push Actor 10, 9

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

