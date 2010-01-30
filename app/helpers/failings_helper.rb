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
end
