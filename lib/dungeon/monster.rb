require_relative '../dungeon'

class Monster

  attr_accessor :name, :life, :gold, :damage, :graphic, :experience

  def initialize(name, life, gold, damage, graphic, experience)
    @name = name
    @life = life.randomize
    @gold = gold.randomize
    @damage = damage
    @graphic = graphic
    @experience = experience
  end

  def attack(player)
    sleep 0.5 # pause for better ui
    
    if dice_roll < player.agility
      puts "The monster lunges forward to attack, but you dodge the blow.\n"
    else
      damage = @damage.randomize
      player.life -= damage
      puts "The monster attacks, inflicting #{damage.to_s} points of damage.\n"
    end
    
    sleep 0.5 # pause for better ui
    
    if player.is_dead?
      puts "Oh no! You have 0 points of life remaining.\n"
    else
      puts "You have #{player.life.to_s} points of life remaining.\n"
    end
    
    sleep 0.5 # pause for better ui 
  end

  def is_dead?
    @life <= 0
  end
  
  # --------------------------------------------------------------------------------------------------------------
  #                                                   MONSTER GRAPHICS
  # --------------------------------------------------------------------------------------------------------------

  A_WOLF_ON_THE_INTERNET = %q{

     \___
     /  (o__
|\   /   x___T
| \  /  | |                 ___
|  \ /  \ \                 | |\_.
|   \ /  \ \                | | _|
|    \/   \ \   __    (  )  |_|/
|     X    \ | // \    )(  __/_\__
|     /     \|// /\\\   __  |     |
|     /      \/ / ooo c||  |     |
|    /   \    /  ===__\/____________
                                   |
                                   |

  }

  A_DANCING_SKELETON = %q{  

                                ,,,
                _\_             ,)_)
           )++++\ 0\              \\\
                 \_(        ,__,   )>              _\_
                 '         o/o /  //          )++++\ 0\
                           `7_(  //                 \_(
     _\_                    _\\\((                  '
)++++\ 0\                   ( , ` \
      \_(                   //\__\/ 
      '                  __/>   \_\______
                        ') )    / _'___, )
   ~~~~~~~~~~ ~~~~~~~~~ ``` ~~~/ /~~~ ~)/~~~~~~~~~~~~
      ~~~~    ~~ ~~           (_(   ~ //_
                     ~~~ ~      )\~~  

  }

  SOME_MEAN_LOOKIN_GHOSTS = %q{



   ___                            ___
 _/ oo\           ___           _/ @@\
( \  -/__       _/ ..\         ( \  O/__
 \    \__)     ( \  0/__        \    \__)
 /     \        \    \__)       /     \
/      _\       /     \        /      _\
`"""""``       /      _\       `"""""``
               `"""""``

  }

  A_SAD_FURRY = %q{

       .`:;ij;f,;,
     .`;sk568G6itz,-",
   .\a\x68888888886r/,-'
 -._sV888P^98^"^9888k,-_"
`.-\Q889"   "    `888/,-',
.-_J88f           188KJ-_.
,-;388|    o o    |888[=-
_".>88l           j88E:._"
 _"Z3886._ ,J.__.488R=;.
  .'/288888888888888S^._"
  '"j^7Z988888885R^L`-.
    ,'./jQV9TYVR\[\`".
       '|'|! |'|`. "
       ./ l  | \
     .'_ _.\ j, `._,.
    (_)_)._) (_.__,._)

  }

  A_SKELETON_WATCHING_TV = %q{

   ______                   ,---.
,-|      |                 C,C)_/
|:|  ..  |                  ?_((,
| |      |                     \\\
`-|______,                ____ //)_
   |__|                 /,-'----//
    ||               c-'``      /
    ||              /  |        |
   _||_            /   | ______ |
  [____]      ...,o    |/      \|

  }

  A_PAIR_OF_LUV_DRAGONS = %q{

    _)               (_ 
   _) \ /\%/\ /\_/\ / (_
  _)  \\\(0 0) (0 0)//  (_
  )_ -- \(oo) (oo)/ -- _(
   )_ / /\\\__,__//\ \ _(
    )_ /   --;--   \ _( 
*.    ( (  )) ((  ) )    .*
  '...(____)z z(____)...'

  }

  A_GROUP_OF_NASTY_SLIMES = %q{

 )/
.oo.            )/
)   `-._      .oo.
`-.___.-'     )   `-._
              `-.___.-'
     )/
    .oo.               )/
    )   `-._          .oo.
    `-.___.-'         )   `-._
                      `-.___.-'

  }

  A_REALLY_SCARY_DRAGON = %q{

        /|                                           |\
       /||             ^               ^             ||\
      / \\__           //               \\\          __// \
     /  |_  \         | \   /     \   / |         /  _|  \
    /  /  \  \         \  \/ \---/ \/  /         /  /     \
   /  /    |  \         \  \/\   /\/  /         /  |       \
  /  /     \   \__       \ ( 0\ /0 ) /       __/   /        \
 /  /       \     \___    \ \_/|\_/ /    ___/     /\         \
/  /         \_)      \___ \/-\|/-\/ ___/      (_/\ \      `  \
  /           /\__)       \/  oVo  \/       (__/   ` \      `  
 /           /,   \__)    (_/\ _ /\_)    (__/         `      \ 
'           //       \__)  (__V_V__)  (__/                    \
  '        /'           \   |{___}|   /         .
 /        /              \/ |{___}| \/\          `
/        '       .        \/{_____}\/  \          \    `
                ,         /{_______}\   \          \    \
               /         /{___/_\___}\   `          \    `

  }

end
