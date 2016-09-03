$( document).on( 'turbolinks:load', function () {

  if ( top.location.pathname === '/card_sorts/new' || top.location.pathname.match( /\/card_sorts\/\d+\/edit/i ) ) {

    // get the card template
    var card = $( '.card' );

    $( '.addCard' ).on( 'click', function () {
      card.clone().appendTo( '.card_sort_cards' );
    });
  }

  if ( top.location.pathname.match( /\/card_sorts\/.+/i ) ) {

    var options = {};
    options.cards = $( '#cardsortContainer' ).data( 'cards' );
    
    // setup the card sort
    var cardsort = new CardSortV2( options );

    // create the addgroup functionality
    $( '#addGroup' ).click( function () {
      console.log( 'addGroup clicked' );
      cardsort.addHTMLGroupToGroupContainer();
    });

    $( 'input[name=commit]' ).on( 'click', function ( e ) {
      e.preventDefault();

      var results = cardsort.getResults();
      $( '#result' ).val( JSON.stringify( results ) );
      
      $( 'form' ).submit();
    });

    // get the card template
    var candidate = $( '.candidate' );

    $( '.addCandidate' ).on( 'click', function () {
      var formGroup = $( '<div />', { 'class': 'form-group' } );
      candidate.clone().appendTo( formGroup ).val('');
      formGroup.appendTo( '.allCandidates' );
    });

  }

});