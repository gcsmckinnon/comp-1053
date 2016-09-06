console.log "plugin.cardsort"

class @CardSort
  
  constructor: ->
    @cardContainer = $('#cardContainer')
    @groupContainer = $('#groupContainer')
    @cards = @cardContainer.find('.card')

    @init()

  init: ->
    @addDraggable()
    @addDroppable()
    @addNesting()

  addDraggable: ->
    @cards.draggable
      helper: 'clone'
      revert: 'invalid'
      appendTo: '#cardContainer'
    return

  addNesting: ->
    if @groupContainer.find('.group').data 'draggable'
      @groupContainer.find('.group').draggable 'destroy'

    @groupContainer.find('.group').draggable
      handle: 'i'
      helper: 'clone'
      revert: 'invalid'
      appendTo: '#groupContainer'

  checkCardContainerStock: ->
    if @cardContainer.find('.card').length == 1
      console.log "empty"
      $('#create-card-sort').prop('disabled', false)
    else
      console.log "not yet: ", @cardContainer.find('.card').length

  addDroppable: ->
    @cardContainer.droppable
      accept: '.card'
      drop: (event, ui) ->
        ui.draggable.appendTo this
      greedy: true
      tolerance: "pointer"

    @groupContainer.droppable
      accept: '.group'
      drop: (event, ui) ->
        ui.draggable.appendTo this
      greedy: true
      tolerance: "pointer"

    if @groupContainer.find('.group').find('.items').data 'droppable'
      @groupContainer.find('.group').find('.items').droppable 'destroy'

    @groupContainer.find('.group').find('.items').droppable
      drop: (event, ui) =>
        ui.draggable.appendTo event.target

        @checkCardContainerStock()

        return
      greedy: true
      tolerance: "pointer"
    return

  addGroup: ->
    group = $('<div >', {'class': 'group'})
    label = $('<div >', {'class': 'label'}).append('<i class="fa fa-arrows ui-draggable-handle">&nbsp;</i><span contentEditable>Click here to edit title</span>')
    items = $('<div >', {'class': 'items'})
    group.append label
    group.append items
    @groupContainer.append group
    @addDroppable();
    @addNesting()

  getOldResults: ->
    rows = []
    groups = @groupContainer.find('.group')
    $(groups).each ->
      label = $(this).find('.label').text()
      groupCards = []
      cards = $(this).find('.card')
      $(cards).each ->
        groupCards.push $(this).find('.label').text()
        return
      rows.push
        label: label
        cards: groupCards
      return
    rows

  getResults: ->
    return @walkit @groupContainer


  walkit: (item, tree)=>
    self = this
    children = $(item).children()
    tree = tree || {}

    $(children).each ->
      if $(this).hasClass('group')
        label = $(this).children('.label').text()
        tree[label] = self.walkit $(this).children('.items'), tree[label]
      else
        tree['cards'] = tree['cards'] || []
        tree['cards'].push $(this).children('.label').text()

    return tree






























