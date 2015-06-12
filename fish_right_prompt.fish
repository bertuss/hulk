function fish_right_prompt
  set -l code $status

  function hulk::status::color -S
    test $code -ne 0; and echo (hulk::err); or echo (hulk::fst)
  end

  set -l base (basename "$PWD")

  if test "$PWD" != "/"
    prompt_pwd | sed "s|~|"(hulk::status::color)"ᴦ"(off)"|g" \
    | sed "s|/|"(hulk::status::color)"/"(off)(hulk::dim)"|g" \
    | sed "s|$base|"(hulk::trd)" $base"(off)"|g"
  end

  if test -d .git
    echo (hulk::status::color)" ≡ "(hulk::snd)(begin
      git_is_touched; and git_branch_name; or echo (hulk::dim)(git_branch_name)
    end)(off)
  else
    echo (hulk::status::color)" ≡"(off)
  end
end
