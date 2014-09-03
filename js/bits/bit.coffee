h = require '../helpers'
require '../polyfills'
TWEEN  = require '../vendor/tween'

class Bit
  oa: {}
  h:  h
  TWEEN: TWEEN
  deg: Math.PI/180
  DEG: Math.PI/180
  px: h.pixel
  parent: h.body

  constructor:(@o={})-> @vars(); @o.isRunLess or @run?()

  vars:->
    # get CANVAS context
    @ctx   = @o.ctx or @ctx
    @px    = h.pixel

    @parent = @default prop: 'parent', def: h.body
    @color  = @default prop: 'color' , def: '#222'
    @colorMap   = @default prop: 'colorMap',  def: [@color]

    @fill         = @default prop: 'fill',    def: 'rgba(0,0,0,0)'
    @fillEnd      = @default prop: 'fillEnd', def: @fill

    @lineWidth= @default prop: 'lineWidth',def: 1
    @lineCap  = @default prop: 'lineCap',  def: 'round'
    @opacity  = @default prop: 'opacity',  def: 1
    @isClearLess  = @default prop: 'isClearLess',  def: false

    @colorObj = h.makeColorObj @color
    @fillObj  = @h.makeColorObj @fill
    # @o = {}

  setProp:(props)->
    for propName, propValue of props
      if propValue? then @[propName] = propValue
    @render()

  default:(o)->
    prop = o.prop; def = o.def

    if @o[prop] and @h.isObj @o[prop]
      if @o[prop]?.end?
        @o["#{prop}End"] = @o[prop].end
        @o["#{prop}"] = @o[prop].start
      else if !@o[prop].x
        for key, value of @o[prop]
          @o["#{prop}End"] = value
          @o["#{prop}"] = parseFloat key
          break

    if @oa[prop] and @h.isObj @oa[prop]
      if @oa[prop]?.end?
        @oa["#{prop}End"] = @oa[prop].end
        @oa["#{prop}"] = @oa[prop].start
      else if !@oa[prop].x
        for key, value of @oa[prop]
          @oa["#{prop}End"] = value
          @oa["#{prop}"] = parseFloat key
          break

    @[prop] = if @oa[prop]?
      @oa[prop]
    else if @o[prop]?
      @o[prop]
    else if @[prop]?
      @[prop]
    else def

  defaultPart:(o)->
    @[o.prop] = null
    @default o

module.exports = Bit


