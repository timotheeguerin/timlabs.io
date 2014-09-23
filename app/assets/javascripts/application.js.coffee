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
          value = scroll  - parallax_background.starting.top
          console.log("val: #{value}, scroll: #{scroll}")
          parallax_background.element.css('transform', "translate3d(0, calc(#{(value * 0.75).toFixed(0)}px - 25vh), 0)")
          console.log('margin: #{}')


  $('a[href*=#]:not([href=#])').click () ->
    speed = $(this).data('speed') or 1000

    if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname)
      console.log(this.hash)
      target = $(this.hash)
      console.log(target)
      #      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      console.log(target.length)
      if target.length
        console.log('len')
        $('html,body').animate({
          scrollTop: target.offset().top - header_height
        }, speed)

        return false

  $(document).on 'mouseenter', '.scale-font-over', () ->
    console.log('test')
    item = $(this)
    scale = item.data('scale')
    item.data('old-size', item.css('font-size'))
    size = parseInt(item.css('font-size')) * scale
    item.animate({"font-size": size})


  $(document).on 'mouseleave', '.scale-font-over', () ->
    item = $(this)
    size = item.data('old-size')
    item.animate({"font-size": size})