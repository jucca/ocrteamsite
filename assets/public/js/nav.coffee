do ->

  ###
  getPage(url)

  synchronously retrieves new page
  and stores it to the cache
  ###
  getPage = (url) ->
    self = @
    @pageCache ?= {}

    if !@pageCache[url]?
      $.ajax
        url: url
        data:
          noLayout:true, forceHTML:true
        async: false
        success: (htmlPartial) ->
          self.pageCache[url] = htmlPartial

    return @pageCache[url]

  ###
  setPage(url)

  sets the page's stage and updates the title
  ###
  setPage = (url) ->

    $('#stage').replaceWith(getPage(url))

    if $('.page-title').length > 0
      document.title = "TEAM JUKKA | " + $('.page-title').text()
    else
      document.title = "TEAM JUKKA"
    ###
    FB.XFBML.parse()
    ga('send', 'pageview')
    ###
  ###
  load correct page on statechange
  ###
  History.Adapter.bind window, 'statechange', ->
    url = History.getState().data.url

    # don't switch to landing page on menu click
    if url != '#'
      setPage(History.getState().data.url)

  ###
  intercepts anchor clicks and navigates to the
  appropriate page
  ###
  $(document).on 'click', 'a:not(.admin-link)', (e) ->
    url = $(@).attr('href')

    if (!$(@).attr('target'))
      e.preventDefault()
      History.pushState(url:url, 'TEAM JUKKA', url)

  ###
  preloads pages after hovering on link for 150ms
  ###
  $(document).on 'mouseenter touchstart', 'a', (e) ->
    $el = $(@)

    timer = setTimeout ->
              getPage($el.attr('href'))
            , 150
    
    $el.on 'mouseleave', (e) ->
      if timer
        clearTimeout(timer)
