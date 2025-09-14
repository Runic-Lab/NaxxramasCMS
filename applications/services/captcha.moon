class CaptchaService
  new: =>
    @captchas = {}

  generate_id: =>
    chars = "abcdefghijklmnopqrstuvwxyz0123456789"
    id = ""
    for i = 1, 16
      pos = math.random(1, #chars)
      id ..= chars\sub(pos, pos)
    id

  generate: =>
    a = math.random(1, 20)
    b = math.random(1, 20)
    answer = a + b
    id = @generate_id!

    @captchas[id] = {
      answer: answer
      expires: os.time! + 300
    }

    {
      id: id
      question: "#{a} + #{b} = ?"
    }

  verify: (id, user_answer) =>
    captcha = @captchas[id]
    return false unless captcha
    return false if captcha.expires < os.time!

    @captchas[id] = nil
    tonumber(user_answer) == captcha.answer

{ :CaptchaService }