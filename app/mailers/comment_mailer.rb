class CommentMailer < ApplicationMailer

  default from: "noreply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.comment_add.subject
  #
  def comment_add(blog, entry, comment)
    @blog = blog
    @entry = entry
    @comment = comment
    mail to: "admin@example.com"
  end
end
