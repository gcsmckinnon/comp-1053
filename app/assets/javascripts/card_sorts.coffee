$(document).on 'turbolinks:load', ->
  if top.location.pathname == '/card_sorts/new' or top.location.pathname.match(/\/card_sorts\/\d+\/edit/i)
    console.log "New or Edit Card Sort"
    # get the card template
    $('.addCard').on 'click', ->
      console.log "adding card"
      cardCont = $('<div />', {class: 'input-group card'})
      cardInput = $('<input />', {class: 'string optional card form-control', placeholder: 'example: Tomatoes', name: 'card_sort[cards][]', type: 'text', id: 'card_sort_cards'})
      cardRemove = $('<div />', {class: 'input-group-addon'}).append($('<a />', {class: 'removeCardFromNewCardSort', href: '#'}).append($('<i />', {class: 'fa fa-remove'})))
      cardCont.append(cardInput)
      cardCont.append(cardRemove)
      cardCont.appendTo '.cards'
      return
    $('.cards').on 'click', '.removeCardFromNewCardSort', (e) ->
      $(this).closest('.card').remove()
      e.preventDefault()

  if top.location.pathname.match(/\/card_sorts\/\d+/i)
    console.log "Starting the CardSort Utility Plugin"
    cardsort = new CardSort
      container: '#cardSortContainer'
      cards: $('#cardSortContainer').data('cards')
      submitButton: $('#create-card-sort')