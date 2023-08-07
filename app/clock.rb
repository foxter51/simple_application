# Represents job executor by schedule
module Clockwork
  every(1.day, 'top10 posts by clock', at: '12:00') do
    LetterJob.perform_async
  end
end
