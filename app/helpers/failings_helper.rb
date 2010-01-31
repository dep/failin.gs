module FailingsHelper
  def css_class_for(state)
    case state
      when "needs_review" then "unrated"
      when "knew"         then "knew"
      when "no_idea"      then "no_idea"
      when "disagree"     then "disagree"
    end
  end

  def title_for(state)
    case state
      when "needs_review" then "Needs review"
      when "knew"         then "I knew this about me"
      when "no_idea"      then "I had no idea"
      when "disagree"     then "I totally disagree"
    end
  end

  def move_left_link(failing)
    return if failing.state == "needs_review"

    state = case failing.state
      when "knew"     then "disagree"
      when "no_idea"  then "knew"
      when "disagree" then "no_idea"
    end

    link_to_remote image_tag("move_left.png", class: "left", title: "Move left one category", style: "display: none;"),
      url: eval("#{state}_failing_path(failing.user, failing)"), method: :put
  end

  def move_right_link(failing)
    return if failing.state == "needs_review"

    state = case failing.state
      when "knew"     then "no_idea"
      when "no_idea"  then "disagree"
      when "disagree" then "knew"
    end

    link_to_remote image_tag("move_right.png", class: "right", title: "Move right one category", style: "display: none;"),
      url: eval("#{state}_failing_path(failing.user, failing)"), method: :put
  end
end
