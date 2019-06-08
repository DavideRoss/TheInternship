using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DossierController : MonoBehaviour
{
    private PlayerController _player;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (_player && Input.GetButton("Fire1"))
        {
            _player.Grab(gameObject);
        }
    }

    private void OnTriggerEnter(Collider other) {
        _player = other.GetComponent<PlayerController>();
        if (!_player) return;
    }

    private void OnTriggerExit(Collider other) {
        _player = null;
    }
}
