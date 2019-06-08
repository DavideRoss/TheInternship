using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CEOController : MonoBehaviour
{
    private PlayerController _player;
    public GameController _game;

    private void OnTriggerEnter(Collider other) {
        _player = other.GetComponent<PlayerController>();
        
        if (_player && _player.HeldDossier)
        {
            // TODO: add point to player
            Destroy(_player.HeldDossier);
            _player.HeldDossier = null;

            StartCoroutine(PickRandomDossier());
        }
    }

    IEnumerator PickRandomDossier() {
        yield return new WaitForEndOfFrame();
        _game.PickRandomDossier();
    }
}
