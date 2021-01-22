/*
GAME RULES:
- The game has 2 players, playing in rounds
- In each turn, a player rolls a dice as many times as he whishes. Each result get added to his ROUND score
- BUT, if the player rolls a 1, all his ROUND score gets lost. After that, it's the next player's turn
- The player can choose to 'Hold', which means that his ROUND score gets added to his GLBAL score. After that, it's the next player's turn
- The first player to reach 100 points on GLOBAL score wins the game
*/

var score = [0,0] , roundScore, Dice , activePlayer ;

function initStartGame(){
    score[0] = 0;
    score[1] = 0;
    roundScore = 0;
    activePlayer = 0;
    Dice = 0;
    document.getElementById('name-0').textContent = 'Player 1';
    document.getElementById('name-1').textContent = 'Player 2';
    document.querySelector('#current-' + 1).innerHTML = '<em>' + 0 + '<em>';
    document.querySelector('#current-' + 0).innerHTML = '<em>' + 0 + '<em>';
    document.getElementById('score-1').textContent = '0' ;
    document.getElementById('score-0').textContent = '0' ;
    document.querySelector('.dice').style.display = 'none';
    document.querySelector('.player-0-panel').classList.add('active');
    document.querySelector('.player-1-panel').classList.remove('active');
}
initStartGame();

function nextPlayerTurn(){
    roundScore = 0;
    activePlayer = (activePlayer === 0) ? 1 : 0;
    document.querySelector('.player-0-panel').classList.toggle('active');
    document.querySelector('.player-1-panel').classList.toggle('active');
    document.querySelector('.dice').style.display = 'none';
    document.querySelector('#current-0').innerHTML = '<em>' + 0 + '<em>';
    document.querySelector('#current-1').innerHTML = '<em>' + 0 + '<em>';
}

document.querySelector('.btn-roll').addEventListener('click',function (){
    if(score[0] >= 20 || score[1] >= 20){
        return
    }
    Dice = Math.floor(Math.random()*6)+1;
    document.querySelector('.dice').style.display = 'block';
    document.querySelector('.dice').src = 'dice-'+Dice+'.png';
    
    if(Dice === 1) {
        nextPlayerTurn();
        document.querySelector('.dice').style.display = 'block';
        document.querySelector('.dice').src = 'dice-'+Dice+'.png';
    }
        
    
    else{
        roundScore += Dice;
        document.querySelector('#current-' + activePlayer).innerHTML = '<em>' + roundScore + '<em>';
        
    }
        
});

document.querySelector('.btn-hold').addEventListener('click',function(){
    score[activePlayer] += roundScore;
    document.querySelector('#score-' + activePlayer).innerHTML = '<em>' + score[activePlayer] + '<em>';
    if(score[0] >= 20 || score[1]>= 20){
        document.querySelector("#name-" + activePlayer).innerHTML = '<b>' + 'Winner!!!!'+ '<b>';
        document.querySelector('.player-' + activePlayer + '-panel').classList.remove('active');
        roundScore = 0;
        alert('The Winner is: Player' + (activePlayer+1));
        return
    }
    nextPlayerTurn();
});

document.querySelector('.btn-new').addEventListener('click',function(){initStartGame();});


