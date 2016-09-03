function CardSortV2 ( options ) {

  console.log( 'Init' );
  this.options = options || {};
  console.log( this.options );

  // get container
  var cardsortContainer = this.options.cardsortContainer || '#cardsortContainer';
  this.cardsortContainer = $( cardsortContainer );

  // create card and group containers
  this.createCardContainer();
  this.createGroupContainer();

  this.setCards();
  this.createHTMLCards();
  this.addHTMLCardsToCardContainer();
  this.addDraggableToCards();

}


// run tests
CardSortV2.prototype.runTests = function () {

  // Insert test call here (proceed method with 'test')

}


// create the card container
CardSortV2.prototype.createCardContainer = function () {

  if ( undefined !== this.cardsortContainer ) {
    // create card container
    var cardContainer = $( '<div />', { 'id': 'cardContainer' } );
    this.cardsortContainer.append( cardContainer );
    this.cardContainer = $( '#cardContainer' );

    // add droppable
    this.cardContainer.droppable({
      greed: true,
      accept: ".card",
      tolerance: "pointer",
      drop: function ( event, ui ) {
        ui.draggable.appendTo( $( this ) );
        ui.draggable.css({
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          heigth: 'auto !important',
          width: 'auto !important'
        });
      }
    });
  } else {
    console.log( '%cFAIL: Missing element ' + this.cardsortContainer + ' in DOM.', 'color: red' );
  }

}


// create the group container
CardSortV2.prototype.createGroupContainer = function () {

  if ( undefined !== this.cardsortContainer ) {
    // create group container
    var groupContainer = $( '<div />', { 'id': 'groupContainer' } );
    this.cardsortContainer.append( groupContainer );
    this.groupContainer = $( '#groupContainer' );

    // add droppable
    this.groupContainer.droppable({
      greed: true,
      accept: ".group",
      tolerance: "pointer",
      drop: function ( event, ui ) {
        ui.draggable.appendTo( $( this ) );
        ui.draggable.css({
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          heigth: '100% !important',
          width: '100% !important'
        });
      }
    });
  } else {
    console.log( '%cFAIL: Missing element ' + this.cardsortContainer + ' in DOM.', 'color: red' );
  }

}


// set the cards property
CardSortV2.prototype.setCards = function () {

  switch ( typeof this.options.cards ) {
    case 'string':
      this.cards = $.parseJSON( this.options.cards );
      break;

    case 'object':
      this.cards = this.options.cards;
      break;

    default:
      console.log( '%cFAIL: this.cards could not be set. Wrong data type or options.cards undefined.', 'color: red' );
      console.log( this.options.cards );
      break;
  }

};

CardSortV2.prototype.testSetCards = function () {

  console.log( 'TEST - ', 'this.options.cards not set: ', this.options.cards );
  this.setCards();
  console.log( 'TEST - ', 'setCards(): ', this.cards );

  this.options.cards = [{label: 'card 1'}, {label: 'card 2'}];
  console.log( 'TEST - ', 'typeof this.options.cards object: ', typeof this.options.cards );
  this.setCards();
  console.log( 'TEST - ', 'setCards(): ', this.cards );

  this.options.cards = JSON.stringify( [{label: 'card 1'}, {label: 'card 2'}] );
  console.log( 'TEST - ', 'typeof this.options.cards: ', typeof this.options.cards );
  this.setCards();
  console.log( 'TEST - ', 'setCards(): ', this.cards );

};


// create the HTML cards
CardSortV2.prototype.createHTMLCards = function () {

  var cardsort = this;
  this.HTMLCards = [];

  if ( undefined !== this.cards ) {

    $( this.cards ).each( function () {
      var card = $( '<div />', { 'class': 'card' } );
      
      if ( this.label ) {
        card.text( this.label );
      }

      cardsort.HTMLCards.push( card );
    });

  } else {
    console.log( '%cFAIL: this.cards not set', 'color: red' );
  } 

};

CardSortV2.prototype.testCreateHTMLCards = function () {

  if ( this.cards ) this.cards = undefined;
  this.createHTMLCards();
  console.log( 'TEST - ', 'createHTMLCards() - no this.cards set:', this.domCards );

  this.options.cards = [{label: 'Card 1'}, {label: 'Card 2'}, {label: 'Card 3'}];
  this.setCards();
  this.createHTMLCards();
  console.log( 'TEST - ', 'createHTMLCards() - no this.cards set:', this.domCards );

};


// add cards to card container
CardSortV2.prototype.addHTMLCardsToCardContainer = function () {

  var cardsort = this;

  if ( undefined !== this.HTMLCards && undefined !== this.cardContainer ) {
    $( this.HTMLCards ).each( function () {
      cardsort.cardContainer.append( this );
    });
  } else {
    console.log( '%cFAIL: this.HTMLCards - ' + this.HTMLCards + ' | ' + 'this.cardContainer' + this.cardContainer, 'color: red' );
  }

};

CardSortV2.prototype.testAddHTMLCardsToCardContainer = function () {

  this.HTMLCards = undefined;
  console.log( 'TEST - ', 'this.HTMLCards not set and this.cardContainer not set', this.HTMLCards, this.cardContainer );

  this.addHTMLCardsToCardContainer();
  console.log( 'TEST - ', 'addHTMLCardsToCardContainer() - this.cardContainer', this.cardContainer );

  this.options.cards = [{label: 'Card 1'}, {label: 'Card 2'}, {label: 'Card 3'}];
  this.setCards();
  this.createHTMLCards();
  this.addHTMLCardsToCardContainer();
  console.log( 'TEST - ', 'addHTMLCardsToCardContainer() - this.cardContainer', this.cardContainer );

};


// add an html group to the group container
CardSortV2.prototype.addHTMLGroupToGroupContainer = function () {

  if ( undefined !== this.groupContainer ) {
    var group = $( '<div />', { 'class': 'group' } );
    var dragHandle = $( '<div />', { 'class': 'drag fa fa-arrows' } );
    var groupLabel = $( '<h2 />', { 'class': 'groupLabel', 'contentEditable': true } );
    var groupItems = $( '<div />', { 'class': 'groupItems' } );

    groupLabel.text( 'Click to Edit' );

    group.append( dragHandle );
    group.append( groupLabel );
    group.append( groupItems );

    // this.addDraggableToGroup( group ); removed for now
    this.addDroppableToGroup( group );

    this.groupContainer.append( group );
  } else {
    console.log( '%cFAIL: this.groupContainer ' + this.groupContainer, 'color: red' );
  }

};

CardSortV2.prototype.testAddHTMLGroupToGroupContainer = function () {

  this.groupContainer = undefined;
  console.log( 'TEST - ', 'this.groupContainer not set and this.groupContainer not set ', this.groupContainer );

  this.addHTMLGroupToGroupContainer();
  console.log( 'TEST - ', 'addHTMLGroupToGroupContainer() - this.groupContainer ', this.groupContainer );

  this.options.cards = [{label: 'Card 1'}, {label: 'Card 2'}, {label: 'Card 3'}];
  this.createGroupContainer();
  this.setCards();
  this.createHTMLCards();
  this.addHTMLGroupToGroupContainer();
  console.log( 'TEST - ', 'addHTMLGroupToGroupContainer() - this.groupContainer ', this.groupContainer );

};


// add jquery ui draggable to the cards
CardSortV2.prototype.addDraggableToCards = function ( options ) {

  var cards = this.cardContainer.find( '.card' );
  
  $( cards ).each( function () {
    $( this ).draggable({
      stack: ".card"
    });
  });

}

// add jquery ui droppable to the groups
CardSortV2.prototype.addDroppableToGroup = function ( group ) {

  $( group ).find( '.groupItems' ).droppable({
    greed: true,
    accept: "*",
    tolerance: "pointer",
    drop: function ( event, ui ) {
      ui.draggable.appendTo( $( this ) );
      ui.draggable.css({
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        height: '100% !important',
        width: '100% !important'
      });

      $( this ).css({
        'height': '100% !important',
        'width': '100% !important'
      });
    }
  });

}

// add draggable to group
CardSortV2.prototype.addDraggableToGroup = function ( group ) {

  $( group ).draggable({
    handle: "div.drag",
    stack: ".group"
  });

};

CardSortV2.prototype.getResults = function () {

  var cardsort = this;
  var rows = [];
  var groups = this.groupContainer.find( '.group' );

  $( groups ).each( function () {

  });

  function walkIt ( ele ) {
  }

};














