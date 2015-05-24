function fst; set_color -o 90f; end
function snd; set_color -o cF3; end
function trd; set_color -o fff; end
function dim; set_color -o 555; end
function err; set_color -o f30; end
function off; set_color normal; end

function fish_prompt
  set -l code $status
  function status::color -S
    test $code -ne 0; and err; or snd
  end
  printf (dim)(date +%H(status::color):(dim)%M)(off)
  printf (status::color)" ≡ "(off)
end
