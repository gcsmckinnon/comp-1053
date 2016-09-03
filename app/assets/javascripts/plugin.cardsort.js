function CardSort ( options ) {

  this.options = options || {};

  /* initialize */
  this.setup();
  this.createCards();
  this.createGroups();
  this.createCardContainer();
  this.createGroupContainer();
  this.addCardsToContainer();
  this.addGroupsToContainer();
  this.addCardAndGroupContainersToCardSortContainer();
  this.populateCards();
  this.addStyleToCards();
  this.addDraggable();
  this.addDroppable();

}

// sets methods and creates layout
CardSort.prototype.setup = function () {

  // starting setup
  this.cardList = this.options.cardList || '{}';
  this.groupList = this.options.groupList || '{}';
  this.cardList = $.parseJSON( this.cardList );
  this.groupList = $.parseJSON( this.groupList );
  this.cardSortContainerSelector = this.options.cardSortContainerSelector || '#cardSortContainer';
  this.cardSortContainer = $( this.cardSortContainerSelector );
  this.addActionButtons();

};

// creates the cards
CardSort.prototype.createCards = function () {

  // set this
  var cardsort = this;

  // set the card selector
  cardsort.cardSelector = cardsort.options.cardSelector || 'cardSelector';

  cardsort.cards = [];

  // iterate through each card and create a div for it
  $(cardsort.cardList).each( function ( index ) {
    var card = $('<div />', { 'class': cardsort.cardSelector });

    if ( this.label ) {
      card.append( '<h2 class="cardLabel">' + this.label + '</h2>' );
    }

    if ( this.clonable ) {
      card.addClass( 'clonable' );
    }
    cardsort.cards.push( card );
  });

};

// creates the groups
CardSort.prototype.createGroups = function () {

  // set the card selector
  this.groupSelector = this.options.groupSelector || 'groupSelector';

  if ( this.groupList.length > 0 ) {
    // set this
    var cardsort = this;

    cardsort.groups = [];

    // iterate through each card and create a div for it
    $( cardsort.groupList ).each( function ( index ) {
      var group = cardsort.createGroup( this );

      cardsort.groups.push( group );
    });
  }

  this.updateGroupLabel();
  this.deleteGroup();

};

// creates the group
CardSort.prototype.createGroup = function ( group ) {

  var groupEle = $( '<div />', { 'class': this.groupSelector } );
  var removeGroupEle = $( '<button />', { 'class': 'removeGroup fa fa-remove' } ).css({
    border: 'none',
    background: 'none'
  });
  groupEle.append( removeGroupEle );
  if ( group.label ) {
    groupEle.append( '<h2 class="groupLabel">' + group.label + '</h2>' );
  }

  return groupEle;

};

CardSort.prototype.createCardContainer = function () {

  // set the card container selector
  this.cardContainerSelector = this.options.cardContainerSelector || 'cardContainerSelector';

  // create the card container
  this.cardContainer = $('<div />', { 'class': this.cardContainerSelector }).append("<p><strong>Drag the card from here to a group.</strong></p>");

};

CardSort.prototype.createGroupContainer = function () {

  // set the card container selector
  this.groupContainerSelector = this.options.groupContainerSelector || 'groupContainerSelector';

  // create the card container
  this.groupContainer = $('<div />', { 'class': this.groupContainerSelector })

};

CardSort.prototype.addCardsToContainer = function () {

  var container = $( this.cardContainer );

  $( this.cards ).each( function (){
    container.append( this );
  });

};

CardSort.prototype.addGroupsToContainer = function () {

  var container = $( this.groupContainer );

  $( this.groups ).each( function (){
    container.append( this );
  });

};

CardSort.prototype.addCardAndGroupContainersToCardSortContainer = function () {

  this.cardSortContainer.append( $( this.cardContainer ) );
  this.cardSortContainer.append( $( this.groupContainer ) );
  $( this.cardContainer ).droppable({
    accept: '.' + this.cardSelector,
    drop: function ( event, ui ) {
      ui.draggable.appendTo( this );
      ui.draggable.css({
        position: 'relative',
        left: 'auto',
        top: 'auto'
      });
    }
  });

};

CardSort.prototype.populateCards = function () {

  var cardsort = this;

  $( this.cardList ).each( function ( index ) {
    var text;
    var image;
    var card = cardsort.cards[index];

    if ( this.image ) {
      cardImage = $( '<div />', { 'class': 'cardImage' } );
      cardImage.css( 'background-image', 'url(' + this.image + ')' );
      $( card ).append( cardImage );
    }

    if ( this.text ) {
      cardText = $( '<div />', { 'class': 'cardText' } );

      // set to HTML if html is set
      if ( this.html ) {
        $( cardText ).html( this.text );
      } else {
        $( cardText ).text( this.text );
      }
      $( card ).append( cardText );
    }
  });

};

CardSort.prototype.addStyleToCards = function () {

  var cardsort = this;

  $( this.cardList ).each( function ( index ) {
    var card = cardsort.cards[index];

    if ( this.css ) {
      card.css( this.css );
    }
  });

};

// adds the jquery draggable to the cards and groups
CardSort.prototype.addDraggable = function () {

  var cardsort = this;

  $( this.cards ).each( function () {
    $( this ).draggable({
      revert: "valid",
      stop: function ( event, ui ) {
        ui.helper.css({ left: 'auto', top: 'auto' })
      }
    });
  });

};

CardSort.prototype.addDroppable = function () {

  if ( $('.' + this.groupSelector ).data( 'droppable' ) ) {
    $( '.' + this.groupSelector ).droppable( "destroy" );
  }

  $( '.' + this.groupSelector ).droppable({
    activate: function ( event, ui ) {},
    accept: '.' + this.cardSelector,
    drop: function ( event, ui ) {
      if ( ui.draggable.hasClass( 'clonable' ) ) {
        $( this ).append( $( ui.helper ).clone().appendTo( this ) );
      } else {
        ui.draggable.appendTo( this );
      }
    }
  });

};

CardSort.prototype.addActionButtons = function () {

  var cardSortContainer = $( this.cardSortContainer );

  // add the action button header
  var actionButtonHeader = $( '<div />', { 'class': 'actionButtonHeader' } );

  // add addGroup button
  var addGroupButton = $( '<button />', { 'class': 'btn btn-default', 'id': 'cardSortAddGroupButton' } );
  addGroupButton.text( 'Add Group' );
  actionButtonHeader.append( addGroupButton );
  this.addGroupToGroupContainer();

  // add the action header to the card sort container
  cardSortContainer.append( actionButtonHeader );

}

CardSort.prototype.addGroupToGroupContainer = function () {

  var cardsort = this;

  $( 'body' ).on( 'click', '#cardSortAddGroupButton', function () {
    var groupJSON = { label: 'Click to change label.' };
    var group = cardsort.createGroup( groupJSON );
    $( cardsort.groupContainer ).append( group );

    // reset the droppable
    cardsort.addDroppable();
  });

};

CardSort.prototype.updateGroupLabel = function () {

  $( 'body' ).on( 'click', '.groupLabel', function ( e ) {
    e.stopPropagation();
    var currentLabel = $( this ).text();
    $( this ).attr('contentEditable', 'true');
  });

}

CardSort.prototype.deleteGroup = function () {

  var cardsort = this;

  $( 'body' ).on( 'click', '.removeGroup', function ( e ) {
    e.stopPropagation();
    
    // get all the grouped cards
    var groupedCards = $( this ).parent().find( '.' + cardsort.cardSelector );

    // return cards to card container
    $( groupedCards ).each( function () {
      $( cardsort.cardContainer ).append( this );
    });

    // remove the group
    $( this ).parent().remove();
  });

};

CardSort.prototype.getResults = function () {

  var cardsort = this;

  // create a temporary rows array
  var rows = [];

  // get the groups
  var groups = $( cardsort.groupContainer ).find( '.' + cardsort.groupSelector );

  // iterate through the groups and fetch the label and cards
  $( groups ).each( function () {
    var label = $( this ).find( '.groupLabel' ).text();
    var groupCards = [];

    var cards = $( this ).find( '.' + cardsort.cardSelector );
    // get all the card labels
    $( cards ).each( function () {
      groupCards.push( $( this ).find( '.cardLabel' ).text() );
    });
    
    // add the data to the rows array
    rows.push( { label: label, cards: groupCards } );
  });

  return rows;

};