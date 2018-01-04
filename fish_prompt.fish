function thor::fst; set_color -o 90f; end
function thor::snd; set_color -o cF3; end
function thor::trd; set_color -o fff; end
function thor::dim; set_color -o 555; end
function thor::err; set_color -o f30; end
function off; set_color normal; end

function fish_prompt
  set -l code $status
  function thor::status::color -S
    test $code -ne 0; and thor::err; or thor::snd
  end
  printf (thor::dim)(date +%H(thor::status::color):(thor::dim)%M)(off)
  printf (thor::status::color)" $ "(off)
end
