import json
import requests

class database:
  value = None
  stat = None
  
  intents = json.loads(requests.get("https://storage.googleapis.com/storingdooglemodel/intents.json"))
  def action(self, context, value):
    
    
    self.value = None
    self.value = value
    context = context[0]['intent']
    print(context)
    if 'stat' in context:
      self.stat = context[5:]
      context = 'summary_statistic'
    default= random.choice(self.intents['intents'][3]['responses'])
    return getattr(self, context, lambda: default)()
    

  def modify_patient(self):
    pid = self.value
    # dob = # display these and ask again
    # char = # display these and ask again
    out = pid
    return out
  
  def access_patient(self):
    pid = self.value
    dob = self.value
    return pid
  
  def pharmacy_search(self):
    pharm = self.value
    return pharm
  
  def hospital_search(self):
    hosp = self.value
    return hosp
  
  def search_google(self):
    search = self.value
    return search
  
  def summary_statistic(self):
    stat = self.value
    pid = self.value
    return stat
  
  def patient_field(self):
    pid = self.value
    # dob = # display these and ask again
    # char = # display these and ask again
    return 