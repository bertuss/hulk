function git_is_repo -d "Check if directory is a repository"
  test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function git_branch_name -d "Get current branch name"
  git_is_repo; and begin
    command git symbolic-ref --short HEAD
  end
end

function git_is_touched -d "Check if repo has any changes"
  git_is_repo; and begin
    test -n (echo (command git status --porcelain))
  end
end

function fish_right_prompt
  set -l code $status

  function thor::status::color -S
    test $code -ne 0; and echo (thor::err); or echo (thor::fst)
  end

  function thor::branch_name
    git_branch_name
  end

  set -l base (basename "$PWD")

  if test "$PWD" != "/"
    prompt_pwd | sed "s|$base|"(thor::trd)" $base"(off)"|g" \
    | sed "s|~|"(thor::status::color)"ᴦ"(off)"|g" \
    | sed "s|/|"(thor::status::color)"/"(off)(thor::dim)"|g"
  end

  if git_is_repo
    echo (thor::status::color)" ≡ "(thor::snd)(begin
      git_is_touched; and thor::branch_name; or echo (thor::dim)(thor::branch_name)
    end)(off)
  else
    echo (thor::status::color)" ≡"(off)
  end
end
