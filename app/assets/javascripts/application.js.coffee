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
  unless /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)
    $('.background-skrollr').each () ->
      parallax_background = {}
      parallax_background.element = $(this)
      parallax_background.height = parallax_background.element.height();
      parallax_background.starting = parallax_background.element.offset();
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


  $(document).find('.example-section').each () ->
    container = $(this)
    variables = {}

    #Update the variables with the value of the input/buttons
    update_variables = (input) ->
      value = ''
      variable = ''
      template = ''
      if input.hasClass('buttons')
        value = input.find('.active').data('value')
        variable = input.data('var')
        template = input.data('format')
      else
        value = input.val()
        variable = input.attr('name')
        template = input.data('format')
      value = '' if input.hasClass('disabled')
      if template and value
        value = template.tmpl(value: value)
      variables[variable] = value

    # Render the template in the pre tag
    render_example = () ->
      container.find('pre').each () ->
        pre = $(this)
        demo = $(pre.data('demo'))
        code = pre.data('template').tmpl(variables)
        pre.text(code)
        if demo
          demo.html(code)
          resize_custom_device(demo.children())

    update_input = ()->
      input = $(this)
      update_variables(input)
      render_example()

    container.find('.buttons, input').each () ->
      update_variables($(this))
    render_example()

    $(container).on 'click', '.buttons a', () ->
      button = $(this)
      buttons = button.closest('.buttons')
      old_active = buttons.find('.active')
      old_active.removeClass('active')
      if old_active.hasClass('toggle-buttons')
        target_buttons = $(old_active.data('target'))
        target_buttons.removeClass('enabled').addClass('disabled')
        update_variables(target_buttons)
      button.addClass('active')
      update_variables(buttons)
      if button.hasClass('toggle-buttons')
        target_buttons = $(button.data('target'))
        target_buttons.removeClass('disabled').addClass('enabled')
        update_variables(target_buttons)
      render_example()

    $(container).on 'change', 'input', update_input
    $(container).on 'mousemove', 'input[type="range"]', update_input


resize_custom_device = (item) ->
  width = (item.data('start-width') or item.width())
  height = (item.data('start-height') or item.height())
  item.data('start-width', width)
  item.data('start-height', height)
  console.log("resize: #{width}, #{height}, #{item.data('ratio')}")
  item.width(width * parseFloat(item.data('ratio')))
  item.height(height * parseFloat(item.data('ratio')))