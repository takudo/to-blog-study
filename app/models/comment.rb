class Comment < ActiveRecord::Base

  def status_text_for_approve_link
    if self.status == 'unapproved'
      'Approve'
    else
      ''
    end
  end

  def body_text_depends_on_status
     if self.status == 'approved'
       self.body
     else
       '(承認待ち)'
     end
  end

end
