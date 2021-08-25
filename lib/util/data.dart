class SliderModel{
  String backgroundImage;
  String title;
  String desc;
  SliderModel(this.backgroundImage, this.title,this.desc);

  void setImage(String getBackgroundimage){
    backgroundImage = getBackgroundimage;
  }
  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc( String getDesc){
    desc = getDesc;
  }

  String getImage(){
    return backgroundImage;
  }

  String getTitle(){
    return title;
  }
  String getDesc(){
    return desc;
  }
}

List <SliderModel> getSlides(){
  List <SliderModel> slides = List<SliderModel>();
  String desc;
  String image;
  String title;
  SliderModel sliderModel = new SliderModel(image, title, desc);

  //1
  sliderModel.setImage('assets/f_png/bg_1.png');
  sliderModel.setTitle('Get easy and fast loans.');
  sliderModel.setDesc('Get your loan in a few simple steps, from the comfort of your smartphone!');
  slides.add(sliderModel);

  sliderModel = new SliderModel(image, title, desc);

  //2
  sliderModel.setImage('assets/f_png/bg_2.png');
  sliderModel.setTitle('Grow your business and fund your needs.');
  sliderModel.setDesc('Do you have financial needs that require immediate solution? Quickfund is your number one plug.');
  slides.add(sliderModel);

  sliderModel = new SliderModel(image, title, desc);

  //3
  sliderModel.setImage('assets/f_png/bg-3.png');
  sliderModel.setTitle('Flexible and convenient repayment.');
  sliderModel.setDesc('Paying back loans are now easier than ever, with our flexible payment methods for everyone.');
  slides.add(sliderModel);

  sliderModel = new SliderModel(image, title, desc);

  return slides;

  }