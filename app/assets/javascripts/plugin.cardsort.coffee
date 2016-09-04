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

  addDraggable: ->
    @cards.draggable()
    return

  addDroppable: ->
    cardContainer = @cardContainer

    if @groupContainer.find('.group').find('.items').data 'droppable'
      @groupContainer.find('.group').find('.items').droppable 'destroy'

    @groupContainer.find('.group').find('.items').droppable
      drop: (event, ui) ->
        ui.draggable.appendTo this
        
        if cardContainer.find('.card').length == 0
          console.log "empty"
          $('#create-card-sort').prop('disabled', false)
        else
          console.log "not yet: ", cardContainer.find('.card').length

        return
      greedy: true
      tolerance: "pointer"
    return

  addGroup: ->
    group = $('<div >', {'class': 'group'})
    label = $('<div >', {'class': 'label'}).text 'Click here to edit title'
    items = $('<div >', {'class': 'items'})
    group.append label
    group.append items
    @groupContainer.append group
    @addDroppable();

  getResults: ->
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



