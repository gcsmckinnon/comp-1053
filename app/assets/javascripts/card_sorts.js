$( document).on( 'turbolinks:load', function () {

  if ( top.location.pathname === '/card_sorts/new' || top.location.pathname.match( /\/card_sorts\/\d+\/edit/i ) ) {
    console.log( 'Card Sorts JavaScript' );

    // get the card template
    var card = $( '.card' );

    $( '.addCard' ).on( 'click', function () {
      card.clone().appendTo( '.card_sort_cards' );
    });
  }

});