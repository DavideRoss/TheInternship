using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CEOController : MonoBehaviour
{
    private PlayerController _player;
    public GameController _game;
    public DossierListController _dossierList;

    private void OnTriggerEnter(Collider other) {
        _player = other.GetComponent<PlayerController>();
        
        if (_player && _player.HeldDossier)
        {
            // TODO: add point to player
            DossierController ctrl = _player.HeldDossier.GetComponent<DossierController>();
            _dossierList.DeleteDossier(ctrl);
            Destroy(_player.HeldDossier);
            _player.HeldDossier = null;
        }
    }
}
