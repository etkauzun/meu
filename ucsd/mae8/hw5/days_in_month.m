function days = days_in_month(month,leap)
% DAYS_IN_MONTH tells how many days are in a given month
%   days is the output number of a month with or without leap year

switch month
    case {'apr' 'jun' 'sep' 'nov'} % 30 days: April, June, September and November
        days = 30;
    case {'jan' 'mar' 'may' 'jul' 'aug' 'oct' 'dec'} % 31 days
        days = 31;
    case {'feb'}
        switch leap
            case 1
                days = 29;
            case 0 
                days = 28;
        end % switch on line 11
    otherwise
        days = 'Invalid inputs';
end % switch on line 5

end % function