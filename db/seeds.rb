# 既存のデータをすべて削除する（依存関係があるため順番が重要）
puts "Destroying all existing data..."
QuizResult.destroy_all
AnswerChoice.destroy_all
Question.destroy_all
QuizHistory.destroy_all
Category.destroy_all
User.destroy_all
puts "All existing data destroyed."

puts "Creating seed data..."

# カテゴリの作成
categories = Category.create!([
  { name: '入国目的' },
  { name: '持ち物・申告' },
  { name: '滞在情報' },
  { name: '職業・身分' },
  { name: '滞在期間・帰国予定' }
])

# 質問と選択肢の作成
# ターゲットに合わせた質問と選択肢
# 入国目的 (Purpose of Entry)
purpose_category = categories.find { |c| c.name == '入国目的' }
Question.create!(
  title_jp: "入国目的は何ですか？",
  title_en: "What is the purpose of your visit?",
  answer_jp: "入国目的は何ですか？",
  answer_en: "What is the purpose of your visit?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "入国目的は何ですか？", content_en: "What is the purpose of your visit?", is_correct: true },
    { content_jp: "職業は何ですか？", content_en: "What is your occupation?", is_correct: false },
    { content_jp: "お名前は？", content_en: "What is your name?", is_correct: false },
    { content_jp: "どこから来ましたか？", content_en: "Where are you from?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "一人で来ましたか？",
  title_en: "Are you traveling alone?",
  answer_jp: "一人で来ましたか？",
  answer_en: "Are you traveling alone?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "一人で来ていますか？", content_en: "Are you traveling alone?", is_correct: true },
    { content_jp: "旅行は好きですか？", content_en: "Do you like traveling?", is_correct: false },
    { content_jp: "気分はどうですか？", content_en: "How are you feeling?", is_correct: false },
    { content_jp: "パスポートはどこですか？", content_en: "Where is your passport?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "〇〇を訪れたことはありますか？",
  title_en: "Have you visited 〇〇 before?",
  answer_jp: "〇〇を訪れたことはありますか？",
  answer_en: "Have you visited 〇〇 before?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "〇〇を訪れたことはありますか？", content_en: "Have you visited 〇〇 before?", is_correct: true },
    { content_jp: "〇〇に住んでいますか？", content_en: "Do you live in 〇〇?", is_correct: false },
    { content_jp: "〇〇の料理は好きですか？", content_en: "Do you like 〇〇 food?", is_correct: false },
    { content_jp: "〇〇の空港は広いですか？", content_en: "Are 〇〇 airports large?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "なぜ〇〇に来たのですか？",
  title_en: "Why did you come to 〇〇?",
  answer_jp: "なぜ〇〇に来たのですか？",
  answer_en: "Why did you come to 〇〇?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "なぜ〇〇に来たのですか？", content_en: "Why did you come to 〇〇?", is_correct: true },
    { content_jp: "なぜ英語を話すのですか？", content_en: "Why do you speak English?", is_correct: false },
    { content_jp: "何歳ですか？", content_en: "How old are you?", is_correct: false },
    { content_jp: "どのくらい滞在しますか？", content_en: "How long will you stay?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "どこから来ましたか？",
  title_en: "Where are you coming from?",
  answer_jp: "どこから来ましたか？",
  answer_en: "Where are you coming from?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "どこから来ましたか？", content_en: "Where are you coming from?", is_correct: true },
    { content_jp: "どこへ行きますか？", content_en: "Where are you going?", is_correct: false },
    { content_jp: "どこで買い物しますか？", content_en: "Where do you shop?", is_correct: false },
    { content_jp: "誰と旅行しますか？", content_en: "Who are you traveling with?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "観光でどこを訪れる予定ですか？",
  title_en: "Where are you planning to visit for sightseeing?",
  answer_jp: "観光でどこを訪れる予定ですか？",
  answer_en: "Where are you planning to visit for sightseeing?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "観光でどこを訪れる予定ですか？", content_en: "Where are you planning to visit for sightseeing?", is_correct: true },
    { content_jp: "どこに住んでいますか？", content_en: "Where do you live?", is_correct: false },
    { content_jp: "何日滞在しますか？", content_en: "How many days will you stay?", is_correct: false },
    { content_jp: "何を食べる予定ですか？", content_en: "What are you planning to eat?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "〇〇での計画はありますか？",
  title_en: "Do you have any plans in 〇〇?",
  answer_jp: "〇〇での計画はありますか？",
  answer_en: "Do you have any plans in 〇〇?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "〇〇での計画はありますか？", content_en: "Do you have any plans in 〇〇?", is_correct: true },
    { content_jp: "〇〇には何回訪れましたか？", content_en: "How many times have you visited 〇〇?", is_correct: false },
    { content_jp: "〇〇のお土産は買いましたか？", content_en: "Did you buy souvenirs from 〇〇?", is_correct: false },
    { content_jp: "〇〇は安全ですか？", content_en: "Is 〇〇 safe?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "今回は誰と旅行に来ましたか？",
  title_en: "Who are you traveling with this time?",
  answer_jp: "今回は誰と旅行に来ましたか？",
  answer_en: "Who are you traveling with this time?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "今回は誰と旅行に来ましたか？", content_en: "Who are you traveling with this time?", is_correct: true },
    { content_jp: "今回は飛行機で来ましたか？", content_en: "Did you come by plane this time?", is_correct: false },
    { content_jp: "今回はどこへ行きますか？", content_en: "Where are you going this time?", is_correct: false },
    { content_jp: "今回は一人ですか？", content_en: "Are you alone this time?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "あなたの職業は何ですか？",
  title_en: "What is your occupation?",
  answer_jp: "あなたの職業は何ですか？",
  answer_en: "What is your occupation?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "あなたの職業は何ですか？", content_en: "What is your occupation?", is_correct: true },
    { content_jp: "あなたの年齢は？", content_en: "What is your age?", is_correct: false },
    { content_jp: "あなたの出身地は？", content_en: "Where are you from?", is_correct: false },
    { content_jp: "あなたの趣味は？", content_en: "What are your hobbies?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "帰国便の予約はありますか？",
  title_en: "Do you have a reservation for your return flight?",
  answer_jp: "帰国便の予約はありますか？",
  answer_en: "Do you have a reservation for your return flight?",
  category: purpose_category,
  answer_choices_attributes: [
    { content_jp: "帰国便の予約はありますか？", content_en: "Do you have a reservation for your return flight?", is_correct: true },
    { content_jp: "帰国は明日ですか？", content_en: "Are you returning tomorrow?", is_correct: false },
    { content_jp: "飛行機は好きですか？", content_en: "Do you like airplanes?", is_correct: false },
    { content_jp: "搭乗券を見せてください。", content_en: "Please show me your boarding pass.", is_correct: false }
  ]
)


# 持ち物・申告 (Possessions & Declarations)
possessions_category = categories.find { |c| c.name == '持ち物・申告' }
Question.create!(
  title_jp: "申告するものはありますか？",
  title_en: "Do you have anything to declare?",
  answer_jp: "申告するものはありますか？",
  answer_en: "Do you have anything to declare?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "申告するものはありますか？", content_en: "Do you have anything to declare?", is_correct: true },
    { content_jp: "何か荷物を運んでいますか？", content_en: "Are you carrying any luggage?", is_correct: false },
    { content_jp: "何か言いたいことはありますか？", content_en: "Do you have anything to say?", is_correct: false },
    { content_jp: "何か聞きたいことはありますか？", content_en: "Do you have any questions?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "食品は持ち込んでいますか？",
  title_en: "Are you bringing any food products?",
  answer_jp: "食品は持ち込んでいますか？",
  answer_en: "Are you bringing any food products?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "何か食品を持ち込んでいますか？", content_en: "Are you bringing any food products?", is_correct: true },
    { content_jp: "何か飲み物を持ち込んでいますか？", content_en: "Are you bringing any drinks?", is_correct: false },
    { content_jp: "何かお土産を持ち込んでいますか？", content_en: "Are you bringing any souvenirs?", is_correct: false },
    { content_jp: "何か本を持ち込んでいますか？", content_en: "Are you bringing any books?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "持参しているお金はいくらですか？",
  title_en: "How much money are you bringing?",
  answer_jp: "持参しているお金はいくらですか？",
  answer_en: "How much money are you bringing?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "持参しているお金はいくらですか？", content_en: "How much money are you bringing?", is_correct: true },
    { content_jp: "持参しているチケットはありますか？", content_en: "Do you have any tickets?", is_correct: false },
    { content_jp: "持参している携帯電話は？", content_en: "Do you have a mobile phone?", is_correct: false },
    { content_jp: "持参している水筒は？", content_en: "Do you have a water bottle?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "禁止品を持ち込んでいませんか？",
  title_en: "Are you bringing any prohibited items?",
  answer_jp: "禁止品を持ち込んでいませんか？",
  answer_en: "Are you bringing any prohibited items?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "禁止品を持ち込んでいませんか？", content_en: "Are you bringing any prohibited items?", is_correct: true },
    { content_jp: "お酒を持ち込んでいますか？", content_en: "Are you bringing alcohol?", is_correct: false },
    { content_jp: "タバコを持ち込んでいますか？", content_en: "Are you bringing tobacco?", is_correct: false },
    { content_jp: "荷物を預けましたか？", content_en: "Did you check your luggage?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "スーツケースの中身を見せてください。",
  title_en: "Please show me the contents of your suitcase.",
  answer_jp: "スーツケースの中身を見せてください。",
  answer_en: "Please show me the contents of your suitcase.",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "スーツケースの中身を見せてください。", content_en: "Please show me the contents of your suitcase.", is_correct: true },
    { content_jp: "スーツケースはどこですか？", content_en: "Where is your suitcase?", is_correct: false },
    { content_jp: "スーツケースは重いですか？", content_en: "Is your suitcase heavy?", is_correct: false },
    { content_jp: "スーツケースは黒ですか？", content_en: "Is your suitcase black?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "お土産は何ですか？",
  title_en: "What kind of souvenirs?",
  answer_jp: "お土産は何ですか？",
  answer_en: "What kind of souvenirs?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "どんなお土産ですか？", content_en: "What kind of souvenirs?", is_correct: true },
    { content_jp: "お土産は好きですか？", content_en: "Do you like souvenirs?", is_correct: false },
    { content_jp: "お土産はたくさんありますか？", content_en: "Do you have many souvenirs?", is_correct: false },
    { content_jp: "お土産をどこで買いましたか？", content_en: "Where did you buy the souvenirs?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "手荷物はこれだけですか？",
  title_en: "Is this all your luggage?",
  answer_jp: "手荷物はこれだけですか？",
  answer_en: "Is this all your luggage?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "手荷物はこれだけですか？", content_en: "Is this all your luggage?", is_correct: true },
    { content_jp: "手荷物はどこにありますか？", content_en: "Where is your luggage?", is_correct: false },
    { content_jp: "手荷物は重いですか？", content_en: "Is your luggage heavy?", is_correct: false },
    { content_jp: "手荷物は誰のものですか？", content_en: "Whose luggage is this?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "免税の範囲を超えていませんか？",
  title_en: "Is this within the duty-free allowance?",
  answer_jp: "免税の範囲を超えていませんか？",
  answer_en: "Is this within the duty-free allowance?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "これは免税範囲内ですか？", content_en: "Is this within the duty-free allowance?", is_correct: true },
    { content_jp: "これは無料ですか？", content_en: "Is this free?", is_correct: false },
    { content_jp: "これは新しいものですか？", content_en: "Is this new?", is_correct: false },
    { content_jp: "これは誰に渡すものですか？", content_en: "Who is this for?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "税関申告書は記入済みですか？",
  title_en: "Have you filled out the customs declaration form?",
  answer_jp: "税関申告書は記入済みですか？",
  answer_en: "Have you filled out the customs declaration form?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "税関申告書は記入済みですか？", content_en: "Have you filled out the customs declaration form?", is_correct: true },
    { content_jp: "税関申告書はどこですか？", content_en: "Where is the customs declaration form?", is_correct: false },
    { content_jp: "税関申고書をなくしましたか？", content_en: "Did you lose the customs declaration form?", is_correct: false },
    { content_jp: "税関申告書は〇〇で必要ですか？", content_en: "Is a customs declaration form required in 〇〇?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "このバッグは誰のものですか？",
  title_en: "Whose bag is this?",
  answer_jp: "このバッグは誰のものですか？",
  answer_en: "Whose bag is this?",
  category: possessions_category,
  answer_choices_attributes: [
    { content_jp: "このバッグは誰のものですか？", content_en: "Whose bag is this?", is_correct: true },
    { content_jp: "このバッグは重いですか？", content_en: "Is this bag heavy?", is_correct: false },
    { content_jp: "このバッグは新しいですか？", content_en: "Is this bag new?", is_correct: false },
    { content_jp: "このバッグの中身は何ですか？", content_en: "What is inside this bag?", is_correct: false }
  ]
)


# 滞在情報 (Stay Information)
stay_category = categories.find { |c| c.name == '滞在情報' }
Question.create!(
  title_jp: "どちらに宿泊されますか？",
  title_en: "Where will you be staying?",
  answer_jp: "どちらに宿泊されますか？",
  answer_en: "Where will you be staying?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "どちらに宿泊されますか？", content_en: "Where will you be staying?", is_correct: true },
    { content_jp: "どこへ行きたいですか？", content_en: "Where do you want to go?", is_correct: false },
    { content_jp: "どこで食事しますか？", content_en: "Where will you eat?", is_correct: false },
    { content_jp: "誰と旅行しますか？", content_en: "Who are you traveling with?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "ホテルの名前を教えてください。",
  title_en: "What is the name of your hotel?",
  answer_jp: "ホテルの名前を教えてください。",
  answer_en: "What is the name of your hotel?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "ホテルの名前を教えてください。", content_en: "What is the name of your hotel?", is_correct: true },
    { content_jp: "ホテルの住所はどこですか？", content_en: "What is the address of your hotel?", is_correct: false },
    { content_jp: "ホテルの電話番号は？", content_en: "What is the phone number of your hotel?", is_correct: false },
    { content_jp: "ホテルの予約はしましたか？", content_en: "Did you make a hotel reservation?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "ホテルの住所を教えてください。",
  title_en: "What is the address of your hotel?",
  answer_jp: "ホテルの住所を教えてください。",
  answer_en: "What is the address of your hotel?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "ホテルの住所を教えてください。", content_en: "What is the address of your hotel?", is_correct: true },
    { content_jp: "ホテルの名前は？", content_en: "What is the name of your hotel?", is_correct: false },
    { content_jp: "ホテルの電話番号は？", content_en: "What is the phone number of your hotel?", is_correct: false },
    { content_jp: "ホテルの予約はしましたか？", content_en: "Did you make a hotel reservation?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "滞在中に他にどこか行く予定はありますか？",
  title_en: "Are you planning to go anywhere else during your stay?",
  answer_jp: "滞在中に他にどこか行く予定はありますか？",
  answer_en: "Are you planning to go anywhere else during your stay?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "滞在中に他にどこか行く予定はありますか？", content_en: "Are you planning to go anywhere else during your stay?", is_correct: true },
    { content_jp: "滞在期間はどのくらいですか？", content_en: "How long will you stay?", is_correct: false },
    { content_jp: "滞在は楽しんでいますか？", content_en: "Are you enjoying your stay?", is_correct: false },
    { content_jp: "滞在は快適ですか？", content_en: "Is your stay comfortable?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "宿泊先は予約済みですか？",
  title_en: "Have you booked your accommodation?",
  answer_jp: "宿泊先は予約済みですか？",
  answer_en: "Have you booked your accommodation?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "宿泊先は予約済みですか？", content_en: "Have you booked your accommodation?", is_correct: true },
    { content_jp: "宿泊先はどこですか？", content_en: "Where is your accommodation?", is_correct: false },
    { content_jp: "予約確認書はありますか？", content_en: "Do you have a booking confirmation?", is_correct: false },
    { content_jp: "宿泊先は安全ですか？", content_en: "Is your accommodation safe?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "友人・親族の住所を教えてください。",
  title_en: "What is the address of your friend or relative?",
  answer_jp: "友人・親族の住所を教えてください。",
  answer_en: "What is the address of your friend or relative?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "友人・親族の住所を教えてください。", content_en: "What is the address of your friend or relative?", is_correct: true },
    { content_jp: "友人・親族の電話番号は？", content_en: "What is your friend or relative's phone number?", is_correct: false },
    { content_jp: "友人・親族は〇〇国籍ですか？", content_en: "Is your friend or relative a 〇〇 citizen?", is_correct: false },
    { content_jp: "友人・親族はどこに住んでいますか？", content_en: "Where does your friend or relative live?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "友人・親族の電話番号を教えてください。",
  title_en: "What is your friend or relative's phone number?",
  answer_jp: "友人・親族の電話番号を教えてください。",
  answer_en: "What is your friend or relative's phone number?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "友人・親族の電話番号を教えてください。", content_en: "What is your friend or relative's phone number?", is_correct: true },
    { content_jp: "友人・親族の住所は？", content_en: "What is your friend or relative's address?", is_correct: false },
    { content_jp: "友人・親族はどこにいますか？", content_en: "Where is your friend or relative?", is_correct: false },
    { content_jp: "電話をかけてもいいですか？", content_en: "May I make a call?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "滞在中の連絡先を教えてください。",
  title_en: "What is your contact information during your stay?",
  answer_jp: "滞在中の連絡先を教えてください。",
  answer_en: "What is your contact information during your stay?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "滞在中の連絡先を教えてください。", content_en: "What is your contact information during your stay?", is_correct: true },
    { content_jp: "滞在中の食事は？", content_en: "What about meals during your stay?", is_correct: false },
    { content_jp: "滞在中に何をする予定ですか？", content_en: "What are you planning to do during your stay?", is_correct: false },
    { content_jp: "滞在中の気分は？", content_en: "How do you feel during your stay?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "ホテルの予約確認書を見せてください。",
  title_en: "Please show me your hotel reservation confirmation.",
  answer_jp: "ホテルの予約確認書を見せてください。",
  answer_en: "Please show me your hotel reservation confirmation.",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "ホテルの予約確認書を見せてください。", content_en: "Please show me your hotel reservation confirmation.", is_correct: true },
    { content_jp: "ホテルの鍵はどこですか？", content_en: "Where is the hotel key?", is_correct: false },
    { content_jp: "ホテルの部屋番号は？", content_en: "What is the hotel room number?", is_correct: false },
    { content_jp: "ホテルのチェックインはしましたか？", content_en: "Did you check in to the hotel?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "滞在中にどこで食事しますか？",
  title_en: "Where will you eat during your stay?",
  answer_jp: "滞在中にどこで食事しますか？",
  answer_en: "Where will you eat during your stay?",
  category: stay_category,
  answer_choices_attributes: [
    { content_jp: "滞在中にどこで食事しますか？", content_en: "Where will you eat during your stay?", is_correct: true },
    { content_jp: "〇〇の料理は好きですか？", content_en: "Do you like 〇〇 food?", is_correct: false },
    { content_jp: "〇〇で何を食べましたか？", content_en: "What did you eat in 〇〇?", is_correct: false },
    { content_jp: "〇〇のレストランは美味しいですか？", content_en: "Are 〇〇 restaurants delicious?", is_correct: false }
  ]
)

# 職業・身分 (Occupation & Status)
occupation_category = categories.find { |c| c.name == '職業・身分' }
Question.create!(
  title_jp: "あなたの職業は何ですか？",
  title_en: "What is your occupation?",
  answer_jp: "あなたの職業は何ですか？",
  answer_en: "What is your occupation?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "あなたの職業は何ですか？", content_en: "What is your occupation?", is_correct: true },
    { content_jp: "あなたの趣味は？", content_en: "What are your hobbies?", is_correct: false },
    { content_jp: "あなたの年齢は？", content_en: "What is your age?", is_correct: false },
    { content_jp: "あなたの家族は？", content_en: "What about your family?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "勤務先はどこですか？",
  title_en: "Where do you work?",
  answer_jp: "勤務先はどこですか？",
  answer_en: "Where do you work?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "勤務先はどこですか？", content_en: "Where do you work?", is_correct: true },
    { content_jp: "どこへ行きたいですか？", content_en: "Where do you want to go?", is_correct: false },
    { content_jp: "どこで買い物しますか？", content_en: "Where do you shop?", is_correct: false },
    { content_jp: "どこに住んでいますか？", content_en: "Where do you live?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "〇〇の会社と関係がありますか？",
  title_en: "Are you affiliated with any 〇〇 company?",
  answer_jp: "〇〇の会社と関係がありますか？",
  answer_en: "Are you affiliated with any 〇〇 company?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "〇〇の会社と関係がありますか？", content_en: "Are you affiliated with any 〇〇 company?", is_correct: true },
    { content_jp: "〇〇の食べ物は好きですか？", content_en: "Do you like 〇〇 food?", is_correct: false },
    { content_jp: "〇〇の空港は綺麗ですか？", content_en: "Are 〇〇 airports clean?", is_correct: false },
    { content_jp: "〇〇での生活は楽しいですか？", content_en: "Is life in 〇〇 fun?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "〇〇で働く予定はありますか？",
  title_en: "Do you plan to work in 〇〇?",
  answer_jp: "〇〇で働く予定はありますか？",
  answer_en: "Do you plan to work in 〇〇?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "〇〇で働く予定はありますか？", content_en: "Do you plan to work in 〇〇?", is_correct: true },
    { content_jp: "〇〇で勉強する予定はありますか？", content_en: "Do you plan to study in 〇〇?", is_correct: false },
    { content_jp: "〇〇で買い物する予定はありますか？", content_en: "Do you plan to shop in 〇〇?", is_correct: false },
    { content_jp: "〇〇で観光する予定はありますか？", content_en: "Do you plan to sightsee in 〇〇?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "学校の名前を教えてください。",
  title_en: "What is the name of your school?",
  answer_jp: "学校の名前を教えてください。",
  answer_en: "What is the name of your school?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "学校の名前を教えてください。", content_en: "What is the name of your school?", is_correct: true },
    { content_jp: "仕事の名前を教えてください。", content_en: "What is the name of your job?", is_correct: false },
    { content_jp: "ホテルの名前を教えてください。", content_en: "What is the name of your hotel?", is_correct: false },
    { content_jp: "友達の名前を教えてください。", content_en: "What is your friend's name?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "身分証明書を見せてください。",
  title_en: "Please show me your identification.",
  answer_jp: "身分証明書を見せてください。",
  answer_en: "Please show me your identification.",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "身分証明書を見せてください。", content_en: "Please show me your identification.", is_correct: true },
    { content_jp: "携帯電話を見せてください。", content_en: "Please show me your mobile phone.", is_correct: false },
    { content_jp: "パスポートを見せてください。", content_en: "Please show me your passport.", is_correct: false },
    { content_jp: "チケットを見せてください。", content_en: "Please show me your ticket.", is_correct: false }
  ]
)
Question.create!(
  title_jp: "あなたはどの会社と取引がありますか？",
  title_en: "Which companies are you doing business with?",
  answer_jp: "あなたはどの会社と取引がありますか？",
  answer_en: "Which companies are you doing business with?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "どの会社と取引がありますか？", content_en: "Which companies are you doing business with?", is_correct: true },
    { content_jp: "どのレストランに行きましたか？", content_en: "Which restaurant did you go to?", is_correct: false },
    { content_jp: "どのホテルに泊まりましたか？", content_en: "Which hotel did you stay at?", is_correct: false },
    { content_jp: "どの空港に来ましたか？", content_en: "Which airport did you come to?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "あなたは学生ですか？",
  title_en: "Are you a student?",
  answer_jp: "あなたは学生ですか？",
  answer_en: "Are you a student?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "あなたは学生ですか？", content_en: "Are you a student?", is_correct: true },
    { content_jp: "あなたは〇〇国籍ですか？", content_en: "Are you a 〇〇 citizen?", is_correct: false },
    { content_jp: "あなたは先生ですか？", content_en: "Are you a teacher?", is_correct: false },
    { content_jp: "あなたは医者ですか？", content_en: "Are you a doctor?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "あなたの職業は自営業ですか？",
  title_en: "Are you self-employed?",
  answer_jp: "あなたの職業は自営業ですか？",
  answer_en: "Are you self-employed?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "あなたの職業は自営業ですか？", content_en: "Are you self-employed?", is_correct: true },
    { content_jp: "あなたの職業はプログラマーですか？", content_en: "Are you a programmer?", is_correct: false },
    { content_jp: "あなたの職業は会社員ですか？", content_en: "Are you a company employee?", is_correct: false },
    { content_jp: "あなたの職業は教師ですか？", content_en: "Are you a teacher?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "〇〇で働く予定はありますか？",
  title_en: "Do you have any plans to work in 〇〇?",
  answer_jp: "〇〇で働く予定はありますか？",
  answer_en: "Do you have any plans to work in 〇〇?",
  category: occupation_category,
  answer_choices_attributes: [
    { content_jp: "〇〇で働く予定はありますか？", content_en: "Do you have any plans to work in 〇〇?", is_correct: true },
    { content_jp: "〇〇で料理をする予定はありますか？", content_en: "Do you plan to cook in 〇〇?", is_correct: false },
    { content_jp: "〇〇で車を運転する予定はありますか？", content_en: "Do you plan to drive a car in 〇〇?", is_correct: false },
    { content_jp: "〇〇で何かを買う予定はありますか？", content_en: "Do you plan to buy anything in 〇〇?", is_correct: false }
  ]
)


# 滞在期間・帰国予定 (Duration of Stay & Departure)
duration_category = categories.find { |c| c.name == '滞在期間・帰国予定' }
Question.create!(
  title_jp: "何日間滞在しますか？",
  title_en: "How many days will you be staying?",
  answer_jp: "何日間滞在しますか？",
  answer_en: "How many days will you be staying?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "何日間滞在しますか？", content_en: "How many days will you be staying?", is_correct: true },
    { content_jp: "何歳ですか？", content_en: "How old are you?", is_correct: false },
    { content_jp: "何時に来ましたか？", content_en: "What time did you arrive?", is_correct: false },
    { content_jp: "何を食べましたか？", content_en: "What did you eat?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "いつ〇〇を出国する予定ですか？",
  title_en: "When do you plan to leave 〇〇?",
  answer_jp: "いつ〇〇を出国する予定ですか？",
  answer_en: "When do you plan to leave 〇〇?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "いつ〇〇を出国する予定ですか？", content_en: "When do you plan to leave 〇〇?", is_correct: true },
    { content_jp: "いつ〇〇に入国しましたか？", content_en: "When did you enter 〇〇?", is_correct: false },
    { content_jp: "いつから〇〇に滞在しますか？", content_en: "When will you stay in 〇〇?", is_correct: false },
    { content_jp: "いつ〇〇を訪れましたか？", content_en: "When did you visit 〇〇?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "航空券の予約はありますか？",
  title_en: "Do you have a flight reservation?",
  answer_jp: "航空券の予約はありますか？",
  answer_en: "Do you have a flight reservation?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "航空券の予約はありますか？", content_en: "Do you have a flight reservation?", is_correct: true },
    { content_jp: "ホテルの予約はありますか？", content_en: "Do you have a hotel reservation?", is_correct: false },
    { content_jp: "レストランの予約はありますか？", content_en: "Do you have a restaurant reservation?", is_correct: false },
    { content_jp: "列車の予約はありますか？", content_en: "Do you have a train reservation?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "帰りの航空券を見せてください。",
  title_en: "Please show me your return flight ticket.",
  answer_jp: "帰りの航空券を見せてください。",
  answer_en: "Please show me your return flight ticket.",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "帰りの航空券を見せてください。", content_en: "Please show me your return flight ticket.", is_correct: true },
    { content_jp: "帰りのバスのチケットを見せてください。", content_en: "Please show me your return bus ticket.", is_correct: false },
    { content_jp: "帰りの電車のチケットを見せてください。", content_en: "Please show me your return train ticket.", is_correct: false },
    { content_jp: "帰りの船のチケットを見せてください。", content_en: "Please show me your return boat ticket.", is_correct: false }
  ]
)
Question.create!(
  title_jp: "ビザはありますか？",
  title_en: "Do you have a visa?",
  answer_jp: "ビザはありますか？",
  answer_en: "Do you have a visa?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "ビザはありますか？", content_en: "Do you have a visa?", is_correct: true },
    { content_jp: "パスポートはありますか？", content_en: "Do you have a passport?", is_correct: false },
    { content_jp: "運転免許証はありますか？", content_en: "Do you have a driver's license?", is_correct: false },
    { content_jp: "健康保険証はありますか？", content_en: "Do you have a health insurance card?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "なぜ、こんなに長く滞在するのですか？",
  title_en: "Why are you staying for so long?",
  answer_jp: "なぜ、こんなに長く滞在するのですか？",
  answer_en: "Why are you staying for so long?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "なぜ、そんなに長く滞在するのですか？", content_en: "Why are you staying for so long?", is_correct: true },
    { content_jp: "なぜ、そんなに早く帰るのですか？", content_en: "Why are you returning so soon?", is_correct: false },
    { content_jp: "なぜ、一人で旅行するのですか？", content_en: "Why are you traveling alone?", is_correct: false },
    { content_jp: "なぜ、〇〇が好きなのですか？", content_en: "Why do you like 〇〇?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "滞在期間を延長する予定はありますか？",
  title_en: "Do you plan to extend your stay?",
  answer_jp: "滞在期間を延長する予定はありますか？",
  answer_en: "Do you plan to extend your stay?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "滞在期間を延長する予定はありますか？", content_en: "Do you plan to extend your stay?", is_correct: true },
    { content_jp: "滞在期間を短縮する予定はありますか？", content_en: "Do you plan to shorten your stay?", is_correct: false },
    { content_jp: "〇〇で働く予定はありますか？", content_en: "Do you plan to work in 〇〇?", is_correct: false },
    { content_jp: "〇〇で結婚する予定はありますか？", content_en: "Do you plan to marry in 〇〇?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "今回の〇〇旅行の予算はいくらですか？",
  title_en: "What is your budget for this trip to 〇〇?",
  answer_jp: "今回の〇〇旅行の予算はいくらですか？",
  answer_en: "What is your budget for this trip to 〇〇?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "今回の〇〇旅行の予算はいくらですか？", content_en: "What is your budget for this trip to 〇〇?", is_correct: true },
    { content_jp: "今回の〇〇旅行は誰と行きますか？", content_en: "Who are you going with on this trip to 〇〇?", is_correct: false },
    { content_jp: "今回の〇〇旅行はどこへ行きますか？", content_en: "Where are you going on this trip to 〇〇?", is_correct: false },
    { content_jp: "今回の〇〇旅行はいつからですか？", content_en: "When does this trip to 〇〇 start?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "〇〇で他にどこかに行く予定はありますか？",
  title_en: "Do you have any plans to go anywhere else in 〇〇?",
  answer_jp: "〇〇で他にどこかに行く予定はありますか？",
  answer_en: "Do you have any plans to go anywhere else in 〇〇?",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "〇〇で他にどこかに行く予定はありますか？", content_en: "Do you have any plans to go anywhere else in 〇〇?", is_correct: true },
    { content_jp: "〇〇で他に何か買う予定はありますか？", content_en: "Do you plan to buy anything else in 〇〇?", is_correct: false },
    { content_jp: "〇〇で他に誰かに会う予定はありますか？", content_en: "Do you plan to meet anyone else in 〇〇?", is_correct: false },
    { content_jp: "〇〇で他に何か食べる予定はありますか？", content_en: "Do you plan to eat anything else in 〇〇?", is_correct: false }
  ]
)
Question.create!(
  title_jp: "帰国便の搭乗券を見せてください。",
  title_en: "Please show me your boarding pass for your return flight.",
  answer_jp: "帰国便の搭乗券を見せてください。",
  answer_en: "Please show me your boarding pass for your return flight.",
  category: duration_category,
  answer_choices_attributes: [
    { content_jp: "帰国便の搭乗券を見せてください。", content_en: "Please show me your boarding pass for your return flight.", is_correct: true },
    { content_jp: "帰国便の予約を見せてください。", content_en: "Please show me your return flight reservation.", is_correct: false },
    { content_jp: "帰国便のチケットを見せてください。", content_en: "Please show me your return flight ticket.", is_correct: false },
    { content_jp: "帰国便の時間を教えてください。", content_en: "Please tell me the time of your return flight.", is_correct: false }
  ]
)

puts "Seed data created successfully!"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?