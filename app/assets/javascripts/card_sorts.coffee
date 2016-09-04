$(document).on 'turbolinks:load', ->
  if top.location.pathname == '/card_sorts/new' or top.location.pathname.match(/\/card_sorts\/\d+\/edit/i)
    # get the card template
    card = $('.card')
    $('.addCard').on 'click', ->
      card.clone().appendTo '.card_sort_cards'
      return

  if top.location.pathname.match(/\/card_sorts\/\d+/i)
    options = {}
    options.cardList = JSON.stringify($('#cardsortContainer').data('cards'))
    options.cardSortContainerSelector = '#cardsortContainer'
    # setup the card sort
    cardsort = new CardSort

    $('#addGroup').on 'click', () ->
      cardsort.addGroup()

    $('input[name=commit]').on 'click', (e) ->
      e.preventDefault()
      results = cardsort.getResults()
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

  return