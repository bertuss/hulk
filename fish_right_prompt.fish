function git::branch_name
  command git symbolic-ref --short HEAD | tr '[:lower:]' '[:upper:]'
end

function git::is_touched
  test -n (echo (command git status --porcelain))
end

function fish_right_prompt
  set -l code $status

  function status::color -S
    test $code -ne 0; and echo (err); or echo (fst)
  end

  set -l base (basename "$PWD")

  if test "$PWD" != "/"
    prompt_pwd | sed "s|~|"(status::color)"ᴦ"(off)"|g" \
    | sed "s|/|"(status::color)"/"(off)(dim)"|g" \
    | sed "s|$base|"(trd)" $base"(off)"|g"
  end

  if test -d .git
    echo (status::color)" ≡ "(snd)(begin
      git::is_touched; and git::branch_name; or echo (dim)(git::branch_name)
    end)(off)
  else
    echo (status::color)" ≡"(off)
  end
end