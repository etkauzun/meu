function [total_score,letter] = assign_grade(homework, midterm, project, final)
% ASSIGN_GRADE calculates a grade based on the student's scores
%   total_score is the student's total score using a formula

hw_sum = (sum(homework) - min(homework)) / 7;
total_score = (0.25*hw_sum) + (0.2*project) + ...
    max(((0.25*midterm) + (0.3*final)), (0.55*final));

if total_score >= 93
    letter = 'A';
elseif total_score >= 90
    letter = 'A-';
elseif total_score >= 87
    letter = 'B+';
elseif total_score >= 83
    letter = 'B';
elseif total_score >= 80
    letter = 'B-';
elseif total_score >= 77
    letter = 'C+';
elseif total_score >= 73
    letter = 'C';
elseif total_score >= 70
    letter = 'C-';
elseif total_score >= 60
    letter = 'D';
elseif total_score < 60
    total_score = 'F';
end % if on line 9

end % function