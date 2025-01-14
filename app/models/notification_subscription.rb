class NotificationSubscription < ApplicationRecord
  self.inheritance_column = 'type2' # change

  TYPES = {
    'EpApplicationFormSubscription' => {
      sendinblue_list_name: 'EpApplicationFormSubscription',
      label: 'Chcem dostávať notifikácie k hlasovaciemu preukazu a voľbám',
      hint: 'Zašleme Vám upozornenie chvíľu pred vypršaním lehoty, aby ste sa uistili, že máte hlasovací preukaz. Taktiež Vám zašleme informačný email pred týmito a ďaľšími voľbami.',
    },
    'VoteSubscription' => {
      sendinblue_list_name: 'VoteSubscription',
      label: 'Chcem dostávať upozornenia k voľbám',
      hint: 'Zašleme Vám správu s praktickými informáciami pred týmito a ďaľšími voľbami.',
    },
    'NextVoteSubscription' => {
      sendinblue_list_name: 'NextVoteSubscription',
      label: 'Chcem dostávať notifikácie k ďalším voľbám',
      hint: 'Zašleme Vám upozornenie pred ďaľšími voľbami, aby ste sa mohli pripraviť.',
    },
    'NewsletterSubscription' => {
      sendinblue_list_name: 'NewsletterSubscription',
      label: 'Chcem odoberať pravidelné novinky Návody.Digital',
      hint: 'Ak chcete vedieť o ďalších zlepšovákoch, ktoré pripravujeme, zvoľte si aj túto možnosť. Neposielame žiadny spam, bude to užitočné a len raz za čas.',
    },
    'BlankJourneySubscription' => {
      label: 'Chcem odoberať informácie k tomuto návodu',
      hint: 'Zašleme Vám e-mail, keď vytvoríme tento návod alebo sa bude diať niečo relevantné.',
    },
  }

  belongs_to :user, optional: true
  belongs_to :journey, optional: true

  def confirm
    self.confirmed_at = Time.now.utc unless self.confirmed_at
    add_email_to_list
    save
  end

  def add_email_to_list
    list_name = TYPES.dig(type, :sendinblue_list_name)
    if list_name.present?
      SubscribeSendinblueJob.perform_later(find_email_for_newsletter, list_name)
    end
  end

  def find_email_for_newsletter
    user ? user.email : email
  end
end

