require "test_helper"

class PariquartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pariquart = pariquarts(:one)
  end

  test "should get index" do
    get pariquarts_url
    assert_response :success
  end

  test "should get new" do
    get new_pariquart_url
    assert_response :success
  end

  test "should create pariquart" do
    assert_difference("Pariquart.count") do
      post pariquarts_url, params: { pariquart: { cote: @pariquart.cote, coureur_id: @pariquart.coureur_id, event_id: @pariquart.event_id, montant: @pariquart.montant, parieur_id: @pariquart.parieur_id, resultat: @pariquart.resultat, solde: @pariquart.solde, typepari: @pariquart.typepari } }
    end

    assert_redirected_to pariquart_url(Pariquart.last)
  end

  test "should show pariquart" do
    get pariquart_url(@pariquart)
    assert_response :success
  end

  test "should get edit" do
    get edit_pariquart_url(@pariquart)
    assert_response :success
  end

  test "should update pariquart" do
    patch pariquart_url(@pariquart), params: { pariquart: { cote: @pariquart.cote, coureur_id: @pariquart.coureur_id, event_id: @pariquart.event_id, montant: @pariquart.montant, parieur_id: @pariquart.parieur_id, resultat: @pariquart.resultat, solde: @pariquart.solde, typepari: @pariquart.typepari } }
    assert_redirected_to pariquart_url(@pariquart)
  end

  test "should destroy pariquart" do
    assert_difference("Pariquart.count", -1) do
      delete pariquart_url(@pariquart)
    end

    assert_redirected_to pariquarts_url
  end
end
