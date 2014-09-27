# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https:#github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require_tree .

parallax_backgrounds = [];
$(document).ready () ->
  header_height = $('header').height()

  $('.background-skrollr').each () ->
    parallax_background = {}
    parallax_background.element = $(this)
    parallax_background.height = parallax_background.element.height();
    parallax_background.starting = parallax_background.element.offset();
    console.log("Stating: #{parallax_background.starting.top}")
    parallax_backgrounds.push(parallax_background)
    parallax_background.element.css('transform', "translate3d(0, -25vh, 0)")


  $(window).scroll () ->
    window.requestAnimationFrame () ->
      scroll = $(window).scrollTop()

      for parallax_background in parallax_backgrounds
        if (scroll + $(window).height() >= parallax_background.starting.top )
          value = scroll - parallax_background.starting.top
          console.log("val: #{value}, scroll: #{scroll}")
          parallax_background.element.css('transform', "translate3d(0, calc(#{(value * 0.75).toFixed(0)}px - 25vh), 0)")
          console.log('margin: #{}')


  $('a[href*=#]:not([href=#])').click () ->
    speed = $(this).data('speed') or 1000

    if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname)
      target = $(this.hash)
      #      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if target.length
        $('html,body').animate({
          scrollTop: target.offset().top
        }, speed)

        return false

  $('.device.device-custom').each () ->
    resize_custom_device($(this))

  $(document).on 'click', '.device.device-change', () ->
    array = ['device-pc', 'device-laptop', 'device-tablet', 'device-phone']
    item = $(this)
    for i in [0...array.length]
      if(item.hasClass(array[i]))
        item.removeClass(array[i])
        j = (i + 1) % array.length
        item.addClass(array[j])
        break

  $(document).on 'change mousemove', '.device-size-control', () ->
    target = $($(this).data('target'))
    target.data('ratio', $(this).val())
    resize_custom_device(target)

  $(document).on 'mouseenter', '.header-control', () ->
    control = $(this)
    header = $(this).closest('header')
    content = header.find('#header-content')
    content.css('float', 'left')
    control.addClass('active')
    content.css('width', "calc(100% - #{control.outerWidth(true)}px")

  $(document).on 'mouseleave', '.header-container', () ->
    header = $(this)
    control = header.find('.header-control')
    content = header.find('#header-content')
    control.removeClass('active')
    content.css('float', 'right')
    content.css('width', 0)

  $(document).find('.example-section').each () ->
    container = $(this)
    variables = {}

    update_variables = (buttons, active = null) ->
      active ||= buttons.find('.active')
      variable = buttons.data('var')
      value = active.data('value')
      variables[variable] = value

    # Render the template in the pre tag
    render_example = () ->
      container.find('pre').each () ->
        pre = $(this)
        demo = $(pre.data('demo'))
        code = pre.data('template').tmpl(variables)
        pre.text(code)
        demo.html(code) if demo

    container.find('.buttons').each () ->
      update_variables($(this))
    render_example()

    $(container).on 'click', '.buttons a', () ->
      button = $(this)
      buttons = button.closest('.buttons')
      buttons.find('.active').removeClass('active')
      button.addClass('active')
      update_variables(buttons, button)
      render_example()

resize_custom_device = (item) ->
  width = (item.data('start-width') or item.width())
  height = (item.data('start-height') or item.height())
  item.data('start-width', width)
  item.data('start-height', height)
  item.width(width * item.data('ratio'))
  item.height(height * item.data('ratio'))