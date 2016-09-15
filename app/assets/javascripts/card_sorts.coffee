$(document).on 'turbolinks:load', ->
  if top.location.pathname == '/card_sorts/new' or top.location.pathname.match(/\/card_sorts\/\d+\/edit/i)
    # get the card template
    card = $('.card')
    $('.addCard').on 'click', ->
      card.clone().appendTo '.card_sort_cards'
      return

  if top.location.pathname.match(/\/card_sorts\/\d+/i)
    createGroupElement = (container) ->
      container = container or $('#cardSortContainer')
      group = $('<div />', 'class': 'group')
      groupLabel = $('<div />', 'class': 'label')
      groupRemove = $('<i />', 'class': 'fa fa-remove')
      groupMinimize = $('<i />', 'class': 'fa fa-minus')
      groupCheck = $('<i />', 'class': 'fa fa-check')
      groupTitle = $('<span />', 'contentEditable': true).html('Edit Label&nbsp;<i class=\'fa fa-pencil\'></i>')
      groupItems = $('<div />', 'class': 'items')
      groupTitle.appendTo groupLabel
      groupRemove.appendTo groupLabel
      groupMinimize.appendTo groupLabel
      groupCheck.appendTo groupLabel
      groupTitle.appendTo groupLabel
      groupLabel.appendTo group
      groupItems.appendTo group
      group.appendTo container
      return group

    # enable setGroup
    setGroupToggleDisabled = ->
      selected = $('.selected')
      clones = $('.clone')
      if selected.length > 0 || clones.length > 0
        $('#setGroup').prop 'disabled', false
      else
        $('#setGroup').prop 'disabled', true
      return

    # Checking if done
    checkDone = ->
      cardsLeft = $('#cardSortContainer > .card').length
      if cardsLeft == 0
        $('#create-card-sort').prop('disabled', false)
      return

    # get results
    getResults = ->
      walkit $('#cardSortContainer')

    # walking the tree
    walkit = (item, tree) ->
      children = $(item).children()
      tree = tree || {}

      $(children).each ->
        if $(this).hasClass('group')
          label = $(this).children('.label').text()
          tree[label] = walkit $(this).children('.items'), tree[label]
        else
          tree['cards'] = tree['cards'] || []
          tree['cards'].push $(this).text()
      tree

    $('#cardSortContainer').on 'click', '.card', (e) ->
      if $(this).hasClass('selected') == false
        $(this).addClass 'selected'
        $(this).removeClass 'clone'
        setGroupToggleDisabled()
      else
        $(this).removeClass 'selected'
        setGroupToggleDisabled()
      e.stopPropagation()
      return

    # clone
    $('.card > .fa-clone').click (e) ->
      if $(this).closest('.card').hasClass('clone')
        $(this).closest('.card').removeClass('clone')
        setGroupToggleDisabled()
      else
        $(this).closest('.card').addClass('clone')
        $(this).closest('.card').removeClass('selected')
        setGroupToggleDisabled()
      e.stopPropagation()
      return

    # add group
    $('#addGroup').click ->
      createGroupElement()
      return

    # remove group
    $('#cardSortContainer').on 'click', '.group > .label > .fa-remove', ->
      $(this).closest('.group').find('.items').children('.group').prependTo '#cardSortContainer'
      $(this).closest('.group').find('.cloned').remove()
      $(this).closest('.group').find('.items').children('.card').prependTo '#cardSortContainer'
      $(this).closest('.group').remove()
      return

    # minimize group
    $('#cardSortContainer').on 'click', '.group > .label > .fa-minus', ->
      $(this).parents('.group').find('.items').hide()
      $(this).addClass 'fa-eye'
      $(this).removeClass 'fa-minus'
      $(this).parents('.label').css 'border-radius': '1em'
      return

    # maximize group
    $('#cardSortContainer').on 'click', '.group > .label > .fa-eye', ->
      $(this).parents('.group').find('.items').show()
      $(this).addClass 'fa-minus'
      $(this).removeClass 'fa-eye'
      $(this).parents('.label').css 'border-radius': '1em 1em 0 0'
      return

    # edit label
    $('#cardSortContainer').on 'click', '.group > .label > span', ->
      $(this).html ''
      return

    $('#cardSortContainer').on 'blur', '.group > .label > span', ->
      if $(this).text() == ''
        $(this).html 'Edit Label&nbsp;<i class=\'fa fa-pencil\'></i>'
        $(this).css 'color': 'rgba(127, 140, 141,1.0)'
      else
        $(this).css 'color': '#ecf0f1'
      return

    # grouping of clicked items
    $('#setGroup').click =>
      # group selected
      selected = $('.selected')
      if selected.length > 0
        group = createGroupElement()
        items = $(group).find('.items')
        selected.appendTo items
        items.children().removeClass 'selected'
        setGroupToggleDisabled()
        checkDone()

      # group clones
      clones = $('.clone')
      if clones.length > 0
        group = createGroupElement()
        items = $(group).find('.items')
        clones.addClass 'cloned'
        clones.clone().appendTo items
        clones.closest('.card').removeClass 'clone'
        clones.closest('.card').removeClass 'cloned'
        items.children().removeClass 'clone'
        items.children('.card').find('i.fa-clone').remove()
        setGroupToggleDisabled()
        checkDone()
      return

    # transferring items to a clicked group
    $('#cardSortContainer').on 'click', '.group > .items', (e) ->
      selected = $('.selected')
      if selected.length > 0
        selected.appendTo $(this)
        $(this).children().removeClass 'selected'
        setGroupToggleDisabled()
        checkDone()

      clones = $('.clone')
      if clones.length > 0
        clones.closest('.card').addClass 'cloned'
        clones.clone().appendTo $(this)
        $(this).children().removeClass 'clone'
        $(this).children().find('i.fa-clone').remove()
        $('#cardSortContainer > .card').removeClass 'clone'
        setGroupToggleDisabled()
        checkDone
      e.stopPropagation()
      return

    # readying group for transfer
    $('#cardSortContainer').on 'click', '.group > .label > .fa-check', (e) ->
      if $(this).parents('.group').hasClass('selected')
        $(this).parents('.group').removeClass 'selected'
      else
        $(this).parents('.group').addClass 'selected'
      e.stopPropagation()
      return

    # transferring item back to the main container
    $('#cardSortContainer').click (e) ->
      selected = $('.selected')
      if selected.length > 0
        if selected.hasClass 'cloned'
          selected.remove()
        else
          selected.appendTo $(this)
          $(this).children().removeClass 'selected'

      e.stopPropagation()
      return

    $('#create-card-sort').on 'click', (e) ->
      results = getResults()
      $('#result').val JSON.stringify(results)
      $('form').submit()
      return

    # get the card template
    candidate = $('.candidate')
    $('.addCandidate').on 'click', ->
      formGroup = $('<div />', 'class': 'form-group')
      candidate.clone().appendTo(formGroup).val ''
      formGroup.appendTo '.allCandidates'
      return












