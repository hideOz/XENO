def player_turn(deck, player_hand, player_field, dealer_hand, dealer_field)           #playerのターン
  puts "
  
        あなたのターンです
        
        
        "
  effect_7_player_judge(deck, player_hand, player_field, dealer_field)          #7の効果の有無を判定し、無い場合は通常ドロー

  player_card_play(deck, player_hand, player_field, dealer_field)        #playerの手札から1枚場に出す

  if dealer_field[0] == 4
    #カードの効果を解決せずにターンエンド
  else
    player_card_effect(deck, player_hand, player_field, dealer_hand, dealer_field)
  end
end

def dealer_turn(deck, dealer_hand, player_field, dealer_field)           #dealerのターン
  puts "
  
        dealerのターンです
        
        
        "
  draw_card_dealer(deck, dealer_hand)                                    #dealerのドロー
  dealer_card_play(deck, dealer_hand, dealer_field)                      #dealerの手札からランダムに1枚場に出す
end


def effect_7_player_judge(deck, player_hand, player_field, dealer_field)
  if player_field[0] == 10
    if player_field[2].nil?     #１ターン目で10を捨てられてもplayer_field[2]は存在しないため
      draw_card_player(deck, player_hand)
    elsif player_field[2] == 7
      effect_7_player(deck, player_hand, player_field, dealer_field)
    elsif !player_field[2] == 7
      draw_card_player(deck, player_hand)
    end
  else
    if player_field[0].nil?     #１ターン目はplayer_field[1]は存在しないため
      draw_card_player(deck, player_hand)
    elsif player_field[0] == 7
      effect_7_player(deck, player_hand, player_field, dealer_field)
    else
      draw_card_player(deck, player_hand)
    end
  end
end

def draw_card_player(deck, player_hand)                                  #playerのドロー
  sift_card = deck.shift(1)
  player_hand.unshift(sift_card[0])
  puts "DECKの残り枚数は、#{deck.length}枚です"
  puts "あなたは#{player_hand[0]}を手札に加えました"
end

def draw_card_dealer(deck, dealer_hand)                                  #dealerのドロー
  sift_card = deck.shift(1)
  dealer_hand.unshift(sift_card[0])
  puts "dealerはドローしました"
  puts "DECKの残り枚数は、#{deck.length}枚です"
end

def player_card_play(deck, player_hand, player_field, dealer_field)      #playerの手札から1枚場に出す
  while player_hand.length > 1
    puts "-----------------------------------"
    puts "相手の場にあるカード：#{dealer_field}"
    puts "-----------------------------------"
    puts "あなたの場にあるカード：#{player_field}"
    puts "-----------------------------------"
    puts "あなたの手札：#{player_hand}"
    puts "場に出すカードを入力して下さい"
    input = gets.to_i
    puts "-----------------------------------"
      if input == 10
        puts "＊＊＊そのカードは場に出せません＊＊＊"
      elsif input == player_hand[0]
        player_field.unshift(player_hand.delete_at(0))
      elsif input == player_hand[1]
        player_field.unshift(player_hand.delete_at(1))
      else
        puts "＊＊＊＊＊無効な値です＊＊＊＊＊"
      end
  end
end



def dealer_card_play(deck, dealer_hand, dealer_field)                   #dealerの手札から1枚場に出す
  random = rand(2)
  if random == 0
    choice = dealer_hand.shift(1)
    dealer_field.unshift(choice[0])
  elsif random == 1
    dealer_field.unshift(dealer_hand.pop)
  end
end

def player_card_effect(deck, player_hand, player_field, dealer_hand, dealer_field)   #playerのカードの効果処理
  if player_field[0] == 1
    effect_1_player(deck, player_field, dealer_hand, dealer_field)
  elsif player_field[0] == 2
    effect_2_player(dealer_hand, dealer_field)
  elsif player_field[0] == 3
    puts "相手の手札は#{dealer_hand}です"
  elsif player_field[0] == 4
    puts "後で書くよ"
  elsif player_field[0] == 5
    effect_5_player(deck, dealer_hand, dealer_field)
  elsif player_field[0] == 6
    effect_6_player(player_hand, dealer_hand)
  elsif player_field[0] == 8
    effect_8_player(player_hand, dealer_hand)
  elsif player_field[0] == 9
    effect_9_player(deck, dealer_hand, dealer_field)
  end
end



def effect_1_player(deck, player_field, dealer_hand, dealer_field)           #playerのカードのそれぞれの効果解決
  if player_field.count(1) + dealer_field.count(1) == 2
    draw_card_dealer(deck, dealer_hand)
    while dealer_hand.length > 1
      puts "相手の手札：#{dealer_hand}"
      puts "相手の手札から捨てたいカードを入力して下さい"
      puts inpit = gets.to_i
      if inpit == dealer_hand[0]
        choice = dealer_hand.shift(1)
        dealer_field.unshift(choice[0])
      elsif inpit == dealer_hand[1]
        dealer_field.unshift(dealer_hand.pop)
      else
        puts "＊＊＊＊＊無効な値です＊＊＊＊＊"
      end
    end
  end
end

def effect_2_player(dealer_hand, dealer_field)
  while true
    puts "捨てさせたいカードを入力して下さい"
    input = gets.to_i
    if dealer_hand[0] == input
      game_set_win
    elsif input < 1 or input > 10
      puts "＊＊＊＊＊無効な値です＊＊＊＊＊"
    else
      puts "そのカードは相手の手札にはありません"
      break
    end
  end
end

def effect_5_player(deck, dealer_hand, dealer_field)
  draw_card_dealer(deck, dealer_hand)
  while dealer_hand.length > 1
    puts "捨てさせたいカードを選択して下さい"
    puts "1枚目のカード：[1] を入力"
    puts "2枚目のカード：[2] を入力"
    input = gets.to_i
    if input == 1
      choice = dealer_hand.shift(1)
      dealer_field.unshift(choice[0])
      puts "相手は#{dealer_field[0]}を捨てました"
    elsif input == 2
      dealer_field.unshift(dealer_hand.pop)
      puts "相手は#{dealer_field[0]}を捨てました"
    else
      puts "＊＊＊＊＊無効な値です＊＊＊＊＊"
    end
  end
end

def effect_6_player(player_hand, dealer_hand)
  puts "相手のカードは#{dealer_hand[0]}です"
  puts "あなたのカードは#{player_hand[0]}です"
  if player_hand[0] > dealer_hand[0]
    game_set_win
  elsif player_hand[0] < dealer_hand[0]
    game_set_lose
  else
    game_set_draw
  end
end

def effect_7_player(deck, player_hand, player_field, dealer_field)
  while true
    puts "デッキの上から3枚を確認します"
    puts "        #{deck[0]},  #{deck[1]},  #{deck[2]}"
    puts "-----------------------------------"
    puts "どのカードを手札に加えますか？"
    input = gets.to_i
    if input == deck[0]
      draw_card_player(deck, player_hand)
      deck.shuffle!
      puts "デッキをシャッフルしました"
      break
    elsif input == deck[1]
      player_hand.unshift(deck.delete_at(1))
      deck.shuffle!
      puts "DECKの残り枚数は、#{deck.length}枚です"
      puts "あなたは#{player_hand[0]}を手札に加えました"
      puts "デッキをシャッフルしました"
      break
    elsif input == deck[2]
      player_hand.unshift(deck.delete_at(2))
      deck.shuffle!
      puts "DECKの残り枚数は、#{deck.length}枚です"
      puts "あなたは#{player_hand[0]}を手札に加えました"
      puts "デッキをシャッフルしました"
      break
    else
      puts "＊＊＊＊＊無効な値です＊＊＊＊＊"
    end
  end
end

def effect_8_player(player_hand, dealer_hand)
  player_hand << dealer_hand.delete_at(0)
  dealer_hand << player_hand.delete_at(0)
  puts "お互いの手札を交換しました"
  puts "相手に[#{dealer_hand[0]}]を渡して、相手から[#{player_hand[0]}]を受け取りました"
end

def effect_9_player(deck, dealer_hand, dealer_field)
  draw_card_dealer(deck, dealer_hand)
  while dealer_hand.length > 1
    puts "相手の手札：#{dealer_hand}"
    puts "相手の手札から捨てたいカードを入力して下さい"
    puts input = gets.to_i
    if input == 10
      game_set_win
    elsif input == dealer_hand[0]
      dealer_field.unshift(dealer_hand.delete_at(0))
      puts "#{dealer_field[0]}を捨てさせました"
    elsif input == dealer_hand[1]
      dealer_field.unshift(dealer_hand.delete_at(1))
      puts "#{dealer_field[0]}を捨てさせました"
    else
      puts "＊＊＊＊＊無効な値です＊＊＊＊＊"
    end
  end
end

def effect_10_player(re_card, player_hand, player_field)
  if player_hand[0] == 10
    puts "10が選ばれたので、手札を全て捨てます"
    player_field.unshift(player_hand.delete_at(1))
    player_field.unshift(player_hand.delete_at(0))
    puts "#{player_field[1]}, #{player_field[0]} が捨てられました"
    puts "英雄の能力によって転生します"
    player_hand << re_card
    puts "転生カード[#{player_hand[0]}]を手札に加えました"
  else player_hand[1] == 10
    puts "10が選ばれたので、手札を全て捨てます"
    player_field.unshift(player_hand.delete_at(0))
    player_field.unshift(player_hand.delete_at(1))
    puts "#{player_field[1]}, #{player_field[0]} が捨てられました"
    puts "英雄の能力によって転生します"
    player_hand << re_card
    puts "転生カード[#{player_hand[0]}]を手札に加えました"
  end
end

def game_set_win
  puts "あなたの勝ちです"
  exit
end

def game_set_lose
  puts "あなたの負けです"
  exit
end

def game_set_draw
  puts "引き分けになりました"
  exit
end




deck = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,10]
player_hand = []
dealer_hand = []
player_field = []
dealer_field = []

deck.shuffle!

draw_card_dealer(deck, dealer_hand)
draw_card_player(deck, player_hand)
re_card = deck.delete_at(1)

while deck.length > 0 
  
  player_turn(deck, player_hand, player_field, dealer_hand, dealer_field)

  dealer_turn(deck, dealer_hand, player_field, dealer_field)

end



