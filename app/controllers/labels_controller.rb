class LabelsController < ApplicationController
  before_action :set_label, only: %i(edit update destroy)

  def index
    @labels = current_user.labels
  end

  def new
    @label = Label.new
  end

  def edit
    current_user_required(@label.user)
  end

  def create
    @label = Label.new(label_params)
    @label.user = current_user

    if @label.save
      redirect_to labels_path, notice: 'ラベルを登録しました'
    else
      render :new
    end
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: 'ラベルを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_url, notice: 'ラベルを削除しました'
  end

  private
    def set_label
      @label = Label.find(params[:id])
    end

    def label_params
      params.require(:label).permit(:name)
    end
end
