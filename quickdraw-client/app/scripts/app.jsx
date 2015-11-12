import '../styles/base.css';
import React from 'react';
import ReactDOM from 'react-dom';
import classNames from 'classnames';

let App = React.createClass({
  getInitialState() {
    return({cards: [], handValue: ""})
  },
  dealCards() {
    let app = this
    $.ajax({
      url: 'http://localhost:9292/api/v1/deal',
      type: 'get',
      dataType: 'json',
      success: function(data) {
        console.log(data)
        app.setState({cards: data.cards, handValue: data.value})
      }
    })
  },
  render() {
    return(
      <div className='container'>
        <div className='jumbotron'>
          <h1 id='title'>QuickDraw</h1>
          <div id='deal-me' className='btn btn-danger' onClick={this.dealCards}>DEAL ME</div>
        </div>
        <Hand cards={this.state.cards} value={this.state.handValue}/>
      </div>
    );
  }
});

let Hand = React.createClass({
  render() {
    let cards = this.props.cards.map(function(card, index) {
      return(<Card name={card} key={index} />)
    })
    return(
      <div>
        <h5>{this.props.value}</h5>
        {cards}
      </div>
    )
  }
});

let Card = React.createClass({
  render() {
    let cardName = this.props.name.split(" ");
    let cardClass = (cardName[2] + "-" + cardName[0]).toLowerCase();; 

    let classes = classNames('thumbnail', cardClass)
    return(
      <div className='col-xs-4'>
        <div className={classes}></div>
      </div>
    )
  }
});



ReactDOM.render(<App />, document.getElementById('content'));