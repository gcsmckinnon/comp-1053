$( document).on( 'turbolinks:load', function () {

  if ( top.location.pathname === '/card_sorts/new' || top.location.pathname.match( /\/card_sorts\/\d+\/edit/i ) ) {

    // get the card template
    var card = $( '.card' );

    $( '.addCard' ).on( 'click', function () {
      card.clone().appendTo( '.card_sort_cards' );
    });
  }

  if ( top.location.pathname.match( /\/card_sorts\/\d+/i ) ) {

    console.log( "hey" );

    var options = {};
    options.cardList = JSON.stringify( $( '#cardsortContainer' ).data( 'cards' ) );
    options.cardSortContainerSelector = '#cardsortContainer';
    
    // setup the card sort
    var cardsort = new CardSort( options );

    // create the addgroup functionality
    // $( '#addGroup' ).click( function () {
    //   console.log( 'addGroup clicked' );
    //   cardsort.addHTMLGroupToGroupContainer();
    // });

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