
class DataState{
  constructor() {
    this.stateClear();
  }
  bool isInit = true;
  bool isRequest = false;
  bool isRequestCancel = false;
  bool isLoading = false;
  bool isLoadingSecond = false;
  bool isError = false;
  bool isErrorNetwork = false;
  bool isSuccess = false;

  stateClear(){
    this.isInit = false;
    this.isRequest = false;
    this.isRequestCancel = false;
    this.isLoading = false;
    this.isLoadingSecond = false;
    this.isError = false;
    this.isErrorNetwork = false;
    this.isSuccess = false;
  }
  stateInit(){this.stateClear(); this.isInit = true;}
  stateRequest(){this.stateClear(); this.isRequest = true;}
  stateRequestCancel(){this.stateClear(); this.isRequestCancel = true;}
  stateLoading(){this.stateClear(); this.isLoading = true;}
  stateLoadingSecond(){this.stateClear(); this.isLoadingSecond = true;}
  stateError(){this.stateClear(); this.isError = true;}
  stateErrorNetwork(){this.stateClear(); this.isErrorNetwork = true;}
  stateSuccess(){this.stateClear(); this.isSuccess = true;}

  bool isModalOpen = false;
  modalOpen(){ this.isModalOpen = true;}
  modalClose(){ this.isModalOpen = false;}

}